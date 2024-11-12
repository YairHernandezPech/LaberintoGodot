extends CharacterBody2D

@onready var move_timer := $Timer
@onready var dialog_box: TextureRect = $Dialog 
var is_moving = false
var speed = 100

@onready var line_edit: LineEdit = $Dialog/LineEdit
@onready var label: Label = $Dialog/Label2
@onready var npcStoper: Node2D = $npcStoper
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D  # Acceso al nodo de audio
@onready var win_audio_player: AudioStreamPlayer2D = $WinAudioStreamPlayer2D  # Acceso al audio de "win"
var has_answered = false  # Nuevo estado para saber si ya respondieron correctamente

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("npc") #esto es para crear un grupo
	_on_Timer_timeout()
	
func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("npc")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !has_answered:  # Solo mostrar el diálogo si no se ha respondido
		dialog_box.visible = true
		dialog_box.dialogue_index = 0
		dialog_box.update_dialogue()
		print("tocando al npc")

		# Reproducir el audio si no está sonando
		if not audio_player.playing:
			audio_player.play()

func _on_LineEdit_text_entered(new_text: String, respuesta: String) -> void:
	if 1 == 1:
		$npcStoper/StaticBody2D/CollisionShape2D.disabled = true
		label.text = ""
		$".".visible = false
		has_answered = true  # Marca que ya se respondió correctamente
		if not win_audio_player.playing:  # Reproducir solo si no está sonando
			win_audio_player.play()
		# Detener el audio cuando el jugador responde correctamente
		audio_player.stop()

		# Aquí puedes agregar cualquier lógica adicional para desactivar otros componentes del NPC

	else:
		label.text = new_text + " es incorrecto"

func _on_button_pressed(respuesta) -> void:
	_on_LineEdit_text_entered(line_edit.text, respuesta)
