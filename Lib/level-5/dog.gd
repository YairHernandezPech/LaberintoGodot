extends CharacterBody2D

@onready var move_timer := $Timer

var is_moving = false

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("dog")
	_on_Timer_timeout();

func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("idle")
