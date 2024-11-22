extends CharacterBody2D

@onready var dialog_box: CanvasLayer = $Dialogcl
@onready var collision_dor := $CollisionShape2D
@onready var area_coll := $Area2D/CollisionShape2D
@onready var move_timer := $Timer

var is_moving = false
var is_player_in_area = false
var speed = 100

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("key")
	_on_Timer_timeout();

func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_in_area = true
		dialog_box.visible = true
		dialog_box.dialogue_index = 0
		dialog_box.update_dialogue() 
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		dialog_box.visible = false
		is_player_in_area = false
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("x") and is_player_in_area:
		var i_key = get_tree().get_nodes_in_group("i-key")
		if i_key.size() > 0 and i_key[0].contador > 0:
			i_key[0].disminuir_contador()
			collision_dor.disabled = true
			$AnimatedSprite2D.play("open")
			$AudioStreamPlayer2D.playing = true
			area_coll.disabled = true
			#await get_tree().create_timer(1).timeout
			#queue_free()
