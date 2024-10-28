extends Node2D

var number_1_pressed = false

func _physics_process(delta):
	
	if Input.is_action_just_pressed("number_4"):
		number_1_pressed = true
		print("Número 4 presionado")

	if number_1_pressed and Input.is_action_just_pressed("number_0"):
		print("Secuencia completa: 4 y luego 0")
		$Sprite2D.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		number_1_pressed = false
