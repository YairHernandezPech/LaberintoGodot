extends CharacterBody2D

# Velocidad de movimiento en el eje X
var velocidad = 100
# Dirección de movimiento (1 = derecha, -1 = izquierda)
var direccion = 1
var player: CharacterBody2D = null  # Referencia al jugador

# Referencia al AnimatedSprite2D
var anim_sprite: AnimatedSprite2D

func _ready():
	# Referencia al AnimatedSprite2D
	anim_sprite = $AnimatedSprite2D
	player = $"../Player1"

func _process(delta):
	# Mover el objeto en función de la dirección
	velocity.x = velocidad * direccion
	move_and_slide()

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
		
func _on_death_animation_finished():
	if is_inside_tree():
		Global.death_count -= 1
		if Global.death_count == 0:
			Global.death_count = 3
			get_tree().change_scene_to_file("res://Lib/menu.tscn")
		else:
			get_tree().reload_current_scene()
