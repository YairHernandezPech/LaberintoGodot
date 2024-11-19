extends CanvasLayer

@onready var move_timer := $Timer
@onready var label := $Label
var is_moving = false
var speed = 100
var contador = 0

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("i-key")
	_on_Timer_timeout();
	
func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("idle")

func incrementar_contador():
	contador += 1
	label.text = str(contador)
	
func disminuir_contador():
	contador -= 1
	label.text = str(contador)
