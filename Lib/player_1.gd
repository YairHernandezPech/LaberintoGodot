extends CharacterBody2D

const speed = 120
var current_state = IDLE
var is_roaming = true
var dir = Vector2.RIGHT

func _ready():
	add_to_group("player")#esto es para crear un grupo
enum {
	IDLE,
	NEW_DIR
}

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		dir = Vector2.LEFT
		current_state = NEW_DIR
	elif Input.is_action_pressed("ui_right"):
		dir = Vector2.RIGHT
		current_state = NEW_DIR
	elif Input.is_action_pressed("ui_up"):
		dir = Vector2.UP
		current_state = NEW_DIR
	elif Input.is_action_pressed("ui_down"):
		dir = Vector2.DOWN
		current_state = NEW_DIR
	else:
		current_state = IDLE

func _physics_process(delta):
	match current_state:
		IDLE:
			$AnimatedSprite2D.play("idle")
			velocity = Vector2.ZERO
		NEW_DIR:
			velocity = dir * speed
			match dir:
				Vector2.LEFT:
					$AnimatedSprite2D.play("left")
				Vector2.RIGHT:
					$AnimatedSprite2D.play("right")
				Vector2.UP:
					$AnimatedSprite2D.play("back")
				Vector2.DOWN:
					$AnimatedSprite2D.play("idle")

	move_and_slide()
