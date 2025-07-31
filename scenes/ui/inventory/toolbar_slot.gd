extends Button
class_name ToolbarSlot

@onready var selected_texture_rect: TextureRect = $MarginContainer3/SelectedTextureRect
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var label: Label = $MarginContainer2/Label

var slot: ItemSlot = null

var is_selected: bool = false:
	set(state):
		selected_texture_rect.hide()
		if state:
			selected_texture_rect.show()

func update_display() -> void:
	selected_texture_rect.hide()
	if not slot or not slot.item:
		reset_display()
		return
	
	texture_rect.texture = slot.item.icon
	label.text = slot.item.name
	if slot.item.max_stack_size <= 1:
		label.hide()

func reset_display() -> void:
	texture_rect.texture = null
	label.text = ""

func update_selected(state: bool) -> void:
	is_selected = state
