extends CharacterBody2D

@export var speed: float = 210.0  # Velocidad de persecución

var player_detected: bool = false
var player: CharacterBody2D = null  # Referencia al jugador

# Referencias a nodos
@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("monster")
	animated_sprite.play("walk")

# Detección de entrada del jugador en el área de detección
func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player = body as CharacterBody2D
		player_detected = true
		print("Jugador detectado")

# Detección de salida del jugador del área de detección
func _on_area_2d_body_exited(body: Node) -> void:
	if body == player:
		player_detected = false
		player = null
		print("Jugador fuera del área de detección")

# Detección de colisión con el jugador
func _on_collision_area_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_detected = false
		velocity = Vector2.ZERO
		print("Tocando al jugador")
		animated_sprite.play("death")  # Cambia a animación de muerte
		_on_death_animation_finished()

# Lógica de persecución en _physics_process
func _physics_process(delta: float) -> void:
	if player_detected and player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	move_and_slide()  # Mueve al fantasma utilizando la velocidad actualizada

# Lógica para finalizar animación de muerte y recargar la escena
func _on_death_animation_finished():
	if is_inside_tree():
		Global.death_count -= 1
		if Global.death_count <= 0:
			Global.death_count = 3
			get_tree().change_scene_to_file("res://Lib/menu.tscn")
		else:
			get_tree().reload_current_scene()
