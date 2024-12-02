extends CharacterBody2D

# Velocidades de movimiento
var velocidad_normal = 100
var velocidad_rapida = 200
var velocidad = velocidad_normal  # Velocidad inicial

# Dirección de movimiento (1 = derecha, -1 = izquierda)
var direccion = 1

var player: CharacterBody2D = null  # Referencia al jugador
var anim_sprite: AnimatedSprite2D  # Referencia al AnimatedSprite2D
var temporizador: Timer  # Temporizador para cambiar la velocidad

func _ready():
	# Referencias a nodos
	anim_sprite = $AnimatedSprite2D
	player = $"../Player1"

	# Crear el temporizador
	temporizador = Timer.new()
	temporizador.wait_time = 5  # 5 segundos
	temporizador.one_shot = false  # Que se repita
	temporizador.connect("timeout", Callable(self, "_on_temporizador_timeout"))  # Usar Callable para conectar la señal
	add_child(temporizador)  # Asegúrate de añadir el temporizador al nodo actual
	temporizador.start()  # Iniciar el temporizador

func _process(delta):
	# Mover el objeto en función de la dirección
	# Cambié velocity.x por velocity (usando Vector2)
	velocity = Vector2(velocidad * direccion, velocity.y)
	move_and_slide()  # Moverse con la nueva velocidad

	# Actualizar la animación en función de la dirección
	if direccion == 1:
		anim_sprite.flip_h = true  # Mirar a la derecha
	else:
		anim_sprite.flip_h = false   # Mirar a la izquierda

	# Verificar si hay una colisión y cambiar la dirección
	if is_on_wall(): 
		direccion *= -1

	# Detectar colisión con el jugador
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider == player:
			_on_death_animation_finished()

func _on_temporizador_timeout():
	# Cambiar entre velocidad normal y rápida
	if velocidad == velocidad_normal:
		velocidad = velocidad_rapida
	else:
		velocidad = velocidad_normal

func _on_death_animation_finished():
	if is_inside_tree():
		Global.death_count -= 1
		if Global.death_count == 0:
			Global.death_count = 3
			get_tree().change_scene_to_file("res://Lib/menu.tscn")
		else:
			get_tree().reload_current_scene()
