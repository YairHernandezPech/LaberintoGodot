extends CharacterBody2D

@onready var move_timer := $Timer
var is_moving = false
var speed = 100

func _ready():
	move_timer.wait_time = 1
	move_timer.start() 
	add_to_group("zapato")
	_on_Timer_timeout();
	
func _on_Timer_timeout():
	is_moving = true
	$AnimatedSprite2D.play("idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("tocando al item")
		var i_zapato = get_tree().get_nodes_in_group("i-zapato")
		if i_zapato.size() > 0:
			i_zapato[0].incrementar_contador()
		$AudioStreamPlayer2D.playing = true
		#await get_tree().create_timer(0.3).timeout
		#queue_free()
		var temp_timer = Timer.new()
		add_child(temp_timer)  # Añadir el temporizador a la escena
		temp_timer.wait_time = 0.3
		temp_timer.one_shot = true  # El temporizador se ejecuta solo una vez
		temp_timer.connect("timeout", Callable(self, "_on_timeout"))  # Conectar la señal de timeout a la función
		temp_timer.start()  # Iniciar el temporizador
	pass # Replace with function body.

# Función que se ejecuta cuando el temporizador se agota
func _on_timeout():
	queue_free()  # Eliminar el zapato
