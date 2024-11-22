extends CanvasLayer

@onready var move_timer := $Timer
@onready var label := $Label
@onready var num_label := $num
@onready var num_panel := $Panel2

var is_moving = false
var speed = 100
var contador = 0

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("i-zapato")
	_on_Timer_timeout();
	num_label.visible = false
	num_panel.visible = false
	
func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("idle")
	
func incrementar_contador():
	contador += 1
	label.text = str(contador)
	$AnimatedSprite2D.play("on")
	
func disminuir_contador():
	if contador > 0:
		contador -= 1  # Aquí estaba correcto
		label.text = str(contador)
		if contador == 0:
			$AnimatedSprite2D.play("idle")
	else:
		print("El contador ya está en 0")  # Esto solo debería imprimirse si `contador` es 0 o menos

func timer_contador(remaining_time):
	num_label.text = "00:%02d" % int(remaining_time)
	

func ocultar_contador(): 
	num_label.visible = false
	num_panel.visible = false

func mostrar_contador():
	num_label.visible = true
	num_panel.visible = true
