extends Node2D

var number_5_pressed = false
var number_0_pressed = false

func _physics_process(delta):
	# Número para resolver la operación 50 / 2 = 25
	
	# Detecta cuando se presiona el número 5
	if Input.is_action_just_pressed("number_5"):
		number_5_pressed = true
		print("Número 5 presionado")
	
	# Después de presionar "5", se espera la siguiente tecla "0" para completar la secuencia
	if number_5_pressed and Input.is_action_just_pressed("number_0"):
		print("Secuencia completa: 5 y luego 0 (resultado correcto: 25)")
		
		# Oculta el Sprite y desactiva la colisión
		$Sprite2D.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		
		# Elimina el obstáculo de la escena completamente
		queue_free()  # Elimina el nodo actual (el obstáculo)
		
		# Resetea los estados de las teclas
		number_5_pressed = false  # Resetea la secuencia para nuevos intentos
		number_0_pressed = false  # Resetea el estado de la tecla 0
