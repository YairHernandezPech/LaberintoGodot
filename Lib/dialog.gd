extends TextureRect

@export var dialogues: Array[String]

var dialogue_index: int = 0

@onready var dialogue_label: Label = $Label

func _ready() -> void:
	visible = false
	update_dialogue()

func update_dialogue() -> void:
	dialogue_label.text = dialogues[dialogue_index]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		dialogue_index += 1
		if dialogue_index < dialogues.size():
			update_dialogue()
		else:
			dialogue_index = 0
			visible = false
