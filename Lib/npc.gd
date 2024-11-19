extends CharacterBody2D

@onready var move_timer := $Timer
@onready var dialog_box: TextureRect = $Dialog 
var is_moving = false
var speed = 100

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("npc")#esto es para crear un grupo
	_on_Timer_timeout();
	
func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("npc")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dialog_box.visible = true
		dialog_box.dialogue_index = 0
		dialog_box.update_dialogue() 
		print("tocando al npc")
		
	pass
	
