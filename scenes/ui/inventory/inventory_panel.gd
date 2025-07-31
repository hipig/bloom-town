extends PanelContainer
class_name InventoryPanel

@export var inventory_resource: InventoryList

@onready var inventory_grid: GridContainer = $VBoxContainer/MarginContainer/InventoryGrid
@onready var toolbar_grid: GridContainer = $VBoxContainer/MarginContainer2/ToolbarGrid
@onready var drag_slot_texture: TextureRect = $DragSlotTexture



var hoving_slot_index: int = -1
var drag_slot_index: int = -1
var drag_slot: ItemSlot = null

var slot_map: Dictionary[int, InventorySlot]
var slot_size: float = 32.0

func _ready() -> void:
	var toolbar_slots = toolbar_grid.get_children()
	var inventory_slots = inventory_grid.get_children()
	var toolbar_size: int = toolbar_slots.size()
	for i in range(toolbar_size + inventory_slots.size()):
		var slot: InventorySlot
		if i < toolbar_size:
			slot = toolbar_slots[i]
		else:
			slot = inventory_slots[i - toolbar_size]
			
		slot.mouse_entered.connect(_on_slot_mouse_entered.bind(i))
		slot.mouse_exited.connect(_on_slot_mouse_exited)
		slot_map[i] = slot
	
	update_display()
		
func update_display() -> void:
	for i in slot_map.keys():
		var slot: InventorySlot = slot_map[i]
		slot.slot = inventory_resource.slots[i]
		slot.update_display()
	
func _process(_delta: float) -> void:
	update_drag_texture_position()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			start_drag()
		else:
			end_drag()

func update_drag_texture_position() -> void:
	if drag_slot_index >= 0:
		drag_slot_texture.global_position = get_global_mouse_position() - Vector2(slot_size / 4, slot_size / 4)
	
func start_drag() -> void:
	if hoving_slot_index < 0:
		return
	
	var slot = inventory_resource.slots[hoving_slot_index]
	if not slot or slot.is_empty():
		return
		
	drag_slot_index = hoving_slot_index
	drag_slot_texture.texture = slot.item.icon
	drag_slot_texture.show()
	
	if slot_map.has(drag_slot_index):
		slot_map[drag_slot_index].hide_display()

func end_drag() -> void:
	if drag_slot_index < 0:
		return
	
	if  hoving_slot_index < 0 and slot_map.has(drag_slot_index):
		slot_map[drag_slot_index].update_display()
		pass
	
	var source_slot = inventory_resource.slots[drag_slot_index]
	var target_slot = inventory_resource.slots[hoving_slot_index]

	if target_slot and target_slot.item and source_slot.item.id == target_slot.item.id:
		inventory_resource.merge_slots(drag_slot_index, hoving_slot_index)
	else:
		inventory_resource.swap_slots(drag_slot_index, hoving_slot_index)
	
	drag_slot_index = -1
	drag_slot_texture.hide()
	
	update_display()
	
func _on_slot_mouse_entered(slot_index: int) -> void:
	hoving_slot_index = slot_index
	
func _on_slot_mouse_exited() -> void:
	hoving_slot_index = -1
		
func add_item(item: ItemData, amount: int = 1) -> bool:
	var success = inventory_resource.add_item(item, amount)
	update_display()
	return success
