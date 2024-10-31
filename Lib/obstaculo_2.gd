extends Node2D

var number_7_pressed = false

func _physics_process(_delta):
	# numero 35
	
	if Input.is_action_just_pressed("number_7"):
		number_7_pressed = true
		print("Número 7 presionado")

	if number_7_pressed and Input.is_action_just_pressed("number_2"):
		print("Secuencia completa: 7 y luego 2")
		$Sprite2D.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		number_7_pressed = false
	
