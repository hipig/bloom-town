extends StateMachineState

var is_attack: bool = false

func _on_enter(actor: Node) -> void:
	actor = actor as Player
	actor.animated_sprite.play("idle_" + actor.animate_direction)

func _on_input(event: InputEvent, _actor: Node) -> void:
	if event.is_action_pressed("attack"):
		is_attack = true

func _on_next(actor: Node) -> void:
	actor = actor as Player
	var currentItem: ItemData = actor.current_item
	if currentItem is ToolItemData and is_attack:
		is_attack = false
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
	elif actor.velocity.length() > 0:
		transition.emit("Walk")
	
	
