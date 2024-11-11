extends CharacterBody2D

@onready var move_timer := $Timer
@onready var dialog_box: TextureRect = $Dialog 
var is_moving = false
var speed = 100

@onready var line_edit: LineEdit = $Dialog/LineEdit
@onready var label: Label = $Dialog/Label2
@onready var npcStoper: Node2D = $Obstaculo3

# Respuesta correcta para la operación 40 / 4
var respuesta = "10"

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("npc") # Esto es para crear un grupo
	_on_Timer_timeout()

func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("npc")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		dialog_box.visible = true
		dialog_box.dialogue_index = 0
		dialog_box.update_dialogue() 
		print("Tocando al NPC")
		$AudioStreamPlayer2D.play()

func _on_LineEdit_text_entered(new_text: String) -> void:
	if new_text == respuesta:
		$Obstaculo3/StaticBody2D/CollisionShape2D.disabled = true
		label.text = "Perfecto"
		dialog_box.visible = false # Oculta el cuadro de diálogo al responder correctamente
		print("Perfecto") # Mensaje cuando la respuesta es correcta
	else:
		label.text = new_text + " es incorrecto"
		print("Error") # Mensaje cuando la respuesta es incorrecta

func _on_button_pressed() -> void:
	_on_LineEdit_text_entered(line_edit.text)
