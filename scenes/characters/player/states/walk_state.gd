extends StateMachineState

var target_position: Vector2 = Vector2.ZERO
var path_update_timer: float = 0.0

func _on_update(_delta: float, actor: Node) -> void:
	actor = actor as Player
	actor.animated_sprite.play("walk_" + actor.animate_direction)
		
func _on_next(actor: Node) -> void:
	actor = actor as Player
	var currentItem: ItemData = actor.current_item
	if currentItem is ToolItemData and Input.is_action_just_pressed("attack"):
		currentItem = currentItem as ToolItemData
		match currentItem.tool_type:
			DataTypes.ToolType.Axe:
				transition.emit("Chopping")
			DataTypes.ToolType.Hoe:
				transition.emit("Tilling")
			DataTypes.ToolType.PickAxe:
				transition.emit("Mining")
			DataTypes.ToolType.Shovel:
				transition.emit("Shoveling")
			DataTypes.ToolType.WateringCan:
				transition.emit("Watering")
	elif actor.velocity.length() == 0:
		transition.emit("Idle")
