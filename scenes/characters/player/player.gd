extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine

var direction: Vector2 = Vector2.ZERO:
	set(dir): update_direction(dir)
	
var animate_direction: String = "down"

var speed: float = 50.0

func _ready() -> void:
	state_machine.start()

func _process(_delta: float) -> void:
	var movement_direction: Vector2 = get_movement_vector()
	if movement_direction != Vector2.ZERO:
		direction = movement_direction

	velocity = movement_direction * speed
	move_and_slide()

func get_movement_vector() -> Vector2:
	var x: float = Input.get_axis("move_left", "move_right")
	var y: float = Input.get_axis("move_up", "move_down")
	return Vector2(x, y).normalized()

func update_direction(dir: Vector2) -> void:
	var x = abs(dir.x)
	var y = abs(dir.y)
	if x > y:
		if dir.x > 0:
			animate_direction = "right"
		else:
			animate_direction = "left"
	elif x < y:
		if dir.y > 0:
			animate_direction = "down"
		else:
			animate_direction = "up"
