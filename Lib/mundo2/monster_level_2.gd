extends CharacterBody2D

@export var speed: float = 400.0  # Velocidad de persecución

@export var point_a: Vector2  # Punto A
@export var point_b: Vector2  # Punto B

var moving_to_b := true  # Para controlar si se mueve hacia el punto B o hacia el punto A

var player_detected := false
var player: CharacterBody2D = null  # Referencia al jugador

func _ready() -> void:
	add_to_group("monster")
	$AnimatedSprite2D.play("walk")
	global_position = point_a  # Asegurarse de que el fantasma empiece en el punto A

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_detected = true
	pass # Replace with function body.

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player_detected = false
		player = null
	pass # Replace with function body.

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_detected = false
		velocity = Vector2.ZERO
		print("Tocando al player desde el collision")
		move_and_slide()
		_on_death_animation_finished()
	pass # Replace with function body.

func _process(delta: float) -> void:
	# Determina la dirección del movimiento
	var target = point_b if moving_to_b else point_a
	var direction = (target - global_position).normalized()

	# Mueve al fantasma hacia el objetivo
	velocity = direction * speed
	move_and_slide()

	# Si el fantasma ha llegado al objetivo, cambia de dirección
	if global_position.distance_to(target) < 5.0:  # Umbral para "llegar"
		moving_to_b = not moving_to_b  # Cambiar dirección al otro punto
		
		# Invertir la dirección de la cara
		$AnimatedSprite2D.flip_h = moving_to_b  # Si se mueve hacia B, el sprite no se voltea (flip_h = false)
												# Si se mueve hacia A, el sprite se voltea (flip_h = true)

func _on_death_animation_finished():
	if is_inside_tree():
		Global.death_count -= 1
		if Global.death_count == 0:
			Global.death_count = 3
			get_tree().change_scene_to_file("res://Lib/menu.tscn")
		else:
			get_tree().reload_current_scene()
