extends CanvasLayer

@onready var move_timer := $Timer
@onready var label := $Label
var is_moving = false
var speed = 100
var contador = 0

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("i-zapato")
	_on_Timer_timeout();
	
func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("idle")
	
func incrementar_contador():
	contador += 1
	label.text = str(contador)
	$AnimatedSprite2D.play("on")
	
func disminuir_contador():
	if contador > 0:
		contador -= 1
		label.text = str(contador)
		if contador == 0:
			$AnimatedSprite2D.play("idle")
