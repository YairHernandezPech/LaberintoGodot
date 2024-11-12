extends Node2D

func _ready() -> void:
	add_to_group("portal")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Tocando el portal")
		body.queue_free()
		get_tree().change_scene_to_file("res://Lib/mundo4/mundo_4.tscn")
	pass # Replace with function body.
