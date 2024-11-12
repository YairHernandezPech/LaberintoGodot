extends CharacterBody2D

@onready var move_timer := $Timer
@onready var dialog_box: TextureRect = $Dialog 
var is_moving = false
var speed = 100

@onready var line_edit: LineEdit = $Dialog/LineEdit
@onready var label: Label = $Dialog/Label2
@onready var npcStoper: Node2D = $npcStoper


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
		$AudioStreamPlayer2D.play()
	pass
	
func _on_LineEdit_text_entered(new_text: String, respuesta: String) -> void:
	if new_text == respuesta:
		$npcStoper/StaticBody2D/CollisionShape2D.disabled = true
		label.text = ""
		$".".visible = false
	else:
		label.text = new_text + " es incorrecto"
	pass
	
	
func _on_button_pressed(respuesta) -> void:
	_on_LineEdit_text_entered(line_edit.text, respuesta)
