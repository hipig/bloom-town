extends CanvasLayer
class_name InventoryUI

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_opened: bool = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_inventory"):
		if is_opened:
			animation_player.play("close")
		else:
			animation_player.play("open")
			
		is_opened = !is_opened
