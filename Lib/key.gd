extends CharacterBody2D

@onready var move_timer := $Timer
@onready var dialog_box: TextureRect = $Dialog
var is_moving = false
var speed = 100

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("key")
	_on_Timer_timeout();
	
	#dialog_box.connect("dialogue_finished", self, "_on_dialogue_finished")
func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("idle")
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dialog_box.visible = true
		dialog_box.dialogue_index = 0
		dialog_box.update_dialogue() 
		await get_tree().create_timer(0.5).timeout  # Espera antes de eliminar
	pass # Replace with function body.
	
#func _on_dialogue_finished() -> void:
#	queue_free()  # Hace que la llave desaparezca


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	queue_free()  # Hace que la llave desaparezca
	pass # Replace with function body.
