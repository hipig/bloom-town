extends PanelContainer
class_name ToolbarPanel

@export var inventory_resource: InventoryList

@onready var slot_container: HBoxContainer = $SlotContainer

var slots: Array[ToolbarSlot] = []

var selected_index: int = 0

func _ready() -> void:
	for child in slot_container.get_children():
		if child is ToolbarSlot:
			slots.append(child)
	
	for i in range(slots.size()):
		var slot: ToolbarSlot = slots[i]
		slot.pressed.connect(_on_pressed.bind(i))
		
	update_display()
	inventory_resource.inventory_changed.connect(_on_inventory_changed)

func update_display() -> void:
	for i in range(slots.size()):
		var slot: ToolbarSlot = slots[i]
		slot.slot = inventory_resource.slots[i]
		slot.update_display()
		
		if selected_index == i:
			update_selected(i)

func update_selected(slot_index: int) -> void:
	for slot in slots:
		slot.update_selected(false)
	
	selected_index = slot_index
	var selected_slot: ToolbarSlot = slots[slot_index]
	selected_slot.update_selected(true)
	
	if selected_slot.slot and not selected_slot.slot.is_empty():
		var item: ItemData = selected_slot.slot.item
		var player = Groups.player
		if player:
			player.current_item = item

func _on_pressed(slot_index: int) -> void:
	if selected_index == slot_index:
		return

	update_selected(slot_index)

func _on_inventory_changed() -> void:
	update_display()
