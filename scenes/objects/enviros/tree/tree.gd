extends Node2D
class_name TreeObject

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hurt_box_component.hurted.connect(_on_hurted)
	health_component.died.connect(_on_died)
	
func _on_hurted(damage: float) -> void:
	health_component.damage(damage)
	animation_player.play("shake")
	
func _on_died() -> void:
	call_deferred("queue_free")
