extends Node2D

func _physics_process(delta):
	
	if Input.is_action_just_pressed("number_1"):
		print("Número 1 presionado")
		$StaticBody2D/CollisionShape2D.disabled = true
