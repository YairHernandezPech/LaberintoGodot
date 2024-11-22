extends CharacterBody2D

const base_speed = 120
var current_speed = base_speed
var current_state = IDLE
var dir = Vector2.RIGHT

@onready var speed_timer := $Timer
var countdown_time = 15
var remaining_time

func _ready():
	add_to_group("player")
	# Inicializa el temporizador con el valor de countdown_time
	speed_timer.wait_time = countdown_time
	speed_timer.connect("timeout", Callable(self, "_on_speed_timer_timeout"))
	remaining_time = countdown_time  # Inicializamos el tiempo restante con el valor completo

enum {
	IDLE,
	NEW_DIR
}

func _process(_delta):
	# Verificamos si el temporizador está en marcha y actualizamos el tiempo restante
	if not speed_timer.is_stopped():
		remaining_time = int(speed_timer.time_left)  # Actualizamos el tiempo restante

	# Mostrar el contador con el tiempo restante
	var i_zapato = get_tree().get_nodes_in_group("i-zapato")
	if i_zapato.size() > 0:
		i_zapato[0].timer_contador(remaining_time)

	# Verificar el movimiento del jugador
	if Input.is_action_pressed("ui_left"):
		dir = Vector2.LEFT
		current_state = NEW_DIR
	elif Input.is_action_pressed("ui_right"):
		dir = Vector2.RIGHT
		current_state = NEW_DIR
	elif Input.is_action_pressed("ui_up"):
		dir = Vector2.UP
		current_state = NEW_DIR
	elif Input.is_action_pressed("ui_down"):
		dir = Vector2.DOWN
		current_state = NEW_DIR
	else:
		current_state = IDLE

	if Input.is_action_just_pressed("z"):
		if i_zapato.size() > 0 and i_zapato[0].contador > 0:
			i_zapato[0].disminuir_contador()
			# Llamar a mostrar_contador con el tiempo restante
			i_zapato[0].timer_contador(remaining_time)
			i_zapato[0].mostrar_contador()
			current_speed = base_speed * 2
			speed_timer.start()  # Iniciar el temporizador


func _physics_process(_delta):
	match current_state:
		IDLE:
			$AnimatedSprite2D.play("idle")
			velocity = Vector2.ZERO
		NEW_DIR:
			velocity = dir * current_speed
			match dir:
				Vector2.LEFT:
					$AnimatedSprite2D.play("left")
				Vector2.RIGHT:
					$AnimatedSprite2D.play("right")
				Vector2.UP:
					$AnimatedSprite2D.play("back")
				Vector2.DOWN:
					$AnimatedSprite2D.play("idle")

	move_and_slide()

func _on_speed_timer_timeout():
	var i_zapato = get_tree().get_nodes_in_group("i-zapato")
	current_speed = base_speed
	# Al finalizar el temporizador, ocultamos el contador
	i_zapato[0].ocultar_contador()
