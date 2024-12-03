extends Node2D

var number_1_pressed = false

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("number_1"):
		number_1_pressed = true
		print("Número 1 presionado")

	if number_1_pressed and Input.is_action_just_pressed("number_6"):
		print("Secuencia completa: 1 y luego 6")
		$Sprite2D.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		number_1_pressed = false
	
