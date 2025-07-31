extends Resource
class_name ItemSlot

@export var item: ItemData = null
@export var amount: int = 0

func is_empty() -> bool:
	return item == null or amount == 0
