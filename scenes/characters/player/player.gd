extends CharacterBody2D
class_name Player

@onready var character_sprite: CharacterSprite = $CharacterSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@onready var hit_box_collision_shape: CollisionShape2D = $HitBoxComponent/CollisionShape2D
@onready var state_machine: StateMachine = $StateMachine

var direction: Vector2i = Vector2i.ZERO:
	set(dir):
		direction = dir
		update_direction(dir)
	
var animate_direction: String = "down"

var speed: float = 50.0

var current_item: ItemData = null

func _ready() -> void:
	state_machine.start()
	character_sprite.set_appearance(0, 7, 0, 1, 0, 3)

func _process(_delta: float) -> void:
	var movement_direction: Vector2i = get_movement_vector()
	if movement_direction != Vector2i.ZERO:
		direction = movement_direction

	velocity = movement_direction * speed
	move_and_slide()

func get_movement_vector() -> Vector2i:
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
