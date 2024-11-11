extends Node2D

var number_8_pressed = false

func _physics_process(delta):
	# Número para resolver la operación 10 * 8 = 80
	
	if Input.is_action_just_pressed("number_8"):
		number_8_pressed = true
		print("Número 8 presionado")

	# Después de presionar "8", se espera la siguiente tecla "0" para completar la secuencia
	if number_8_pressed and Input.is_action_just_pressed("number_0"):
		print("Secuencia completa: 8 y luego 0 (resultado correcto: 80)")
		$Sprite2D.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		number_8_pressed = false  # Resetea la secuencia para nuevos intentos
