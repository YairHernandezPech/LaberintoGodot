extends Node2D

var number_3_pressed = false

func _physics_process(_delta):
	# numero 35
	
	if Input.is_action_just_pressed("number_3"):
		number_3_pressed = true
		print("Número 3 presionado")

	if number_3_pressed and Input.is_action_just_pressed("number_5"):
		print("Secuencia completa: 3 y luego 5")
		$Sprite2D.visible = false
		$StaticBody2D/CollisionShape2D.disabled = true
		number_3_pressed = false
	
