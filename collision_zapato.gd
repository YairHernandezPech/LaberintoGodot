extends Area2D

@onready var collition := $CollisionShape2D
@onready var dialog_box: CanvasLayer = $Dialogcl
var is_player_in_area = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_area = true
		dialog_box.visible = true
		dialog_box.dialogue_index = 0
		dialog_box.update_dialogue() 
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		dialog_box.visible = false
		is_player_in_area = false
	pass # Replace with function body.
