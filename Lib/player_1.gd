extends CharacterBody2D

const base_speed = 120
var current_speed = base_speed
var current_state = IDLE
var dir = Vector2.RIGHT

@onready var speed_timer := $Timer
var countdown_time = 15

var num_label
var num_panel

func _ready():
	add_to_group("player")
	var i_zapato = get_node("/root/Mundo5/i-zapato")
	speed_timer.wait_time = countdown_time  # Establecer el tiempo de espera inicial
	speed_timer.connect("timeout", Callable(self, "_on_speed_timer_timeout"))
	
	num_label = i_zapato.get_node("num")
	num_panel = i_zapato.get_node("Panel2") 

	# Configurar la visibilidad del label y panel
	if num_label and num_panel:
		num_label.visible = false
		num_panel.visible = false
	else:
		print("Error: No se encontraron los nodos 'num' o 'Panel2' en i-zapato.")

enum {
	IDLE,
	NEW_DIR
}

func _process(_delta):
	# Actualizar el tiempo restante en el label
	if not speed_timer.is_stopped():  # Verificar si el temporizador está activo
		var remaining_time = speed_timer.time_left  # Obtener el tiempo restante en el temporizador
		num_label.text = "00:%02d" % int(remaining_time)  # Mostrar el tiempo restante en el label

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
		var i_zapato = get_tree().get_nodes_in_group("i-zapato")
		if i_zapato.size() > 0 and i_zapato[0].contador > 0:
			i_zapato[0].disminuir_contador()
			current_speed = base_speed * 2
			speed_timer.start()  # Iniciar el temporizador
			if num_label and num_panel:
				num_label.visible = true
				num_panel.visible = true

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
	# Cuando el temporizador termine, restablecer la velocidad y ocultar el label
	current_speed = base_speed
	if num_label and num_panel:
		num_label.visible = false
		num_panel.visible = false
	else:
		print("Error: num_label o num_panel no están inicializados.")
