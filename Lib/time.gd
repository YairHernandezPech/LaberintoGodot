# Script del temporizador extendido
extends Node
@onready var label = $Label
@onready var timer = $Timer

func _ready() -> void:
	timer.start()
	timer.timeout.connect(_on_timer_timeout) # Usando Callable

func time_left_to_live():
	var time_left = timer.time_left
	Global.minute = floor(time_left / 60)
	Global.second = int(time_left) % 60
	return [Global.minute, Global.second]

func _process(_delta: float) -> void:
	label.text = "%02d:%02d" % time_left_to_live()

func _on_timer_timeout():
	$GameOver.text = "Time out"
	$TimerFunc.wait_time = 1
	$TimerFunc.start()
	await $TimerFunc.timeout  # Esperar a que termine el tiempo del temporizador
	_on_death_animation_finished()

func _on_death_animation_finished():
	if is_inside_tree():
		Global.death_count -= 1
		if Global.death_count == 0:
			Global.death_count = 3
			get_tree().change_scene_to_file("res://Lib/menu.tscn")
		else:
			get_tree().reload_current_scene()
