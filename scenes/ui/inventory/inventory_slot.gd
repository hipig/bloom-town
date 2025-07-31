extends Button
class_name InventorySlot

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var label: Label = $MarginContainer2/Label

var slot: ItemSlot = null

func update_display() -> void:
	if not slot or not slot.item:
		reset_display()
		return
	
	texture_rect.show()
	label.show()
	texture_rect.texture = slot.item.icon
	label.text = slot.item.name
	if slot.item.max_stack_size <= 1:
		label.hide()

func reset_display() -> void:
	texture_rect.texture = null
	label.text = ""

func hide_display() -> void:
	texture_rect.hide()
	label.hide()
