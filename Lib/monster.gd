extends CharacterBody2D

@export var speed := 210.0  # Velocidad de persecución

var player_detected := false
var player: CharacterBody2D = null  # Referencia al jugador

func _ready() -> void:
	add_to_group("monster")
	$AnimatedSprite2D.play("walk")


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
	if player_detected and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
func _on_death_animation_finished():
	if is_inside_tree():
		Global.death_count -= 1
		if Global.death_count == 0:
			Global.death_count = 3
			get_tree().change_scene_to_file("res://Lib/menu.tscn")
		else:
			get_tree().reload_current_scene()
