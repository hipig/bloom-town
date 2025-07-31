extends Resource
class_name InventoryList

signal inventory_changed

@export var slots: Array[ItemSlot] = []

func add_item(item: ItemData, amount: int = 1) -> bool:
	for slot in slots:
		if not slot.is_empty() and slot.item.id == item.id and slot.amount < item.max_stack_size:
			var space_left = item.max_stack_size - slot.amount
			var to_add = min(space_left, amount)
			slot.amount += to_add
			amount -= to_add
			if amount <= 0: return true
	
	for slot in slots:
		if slot.is_empty():
			slot.item = item
			slot.amount = min(amount, item.max_stack_size)
			amount -= slot.amount
			if amount <= 0: return true
	
	return amount <= 0

func swap_slots(from_index: int, to_index: int):
	if from_index < 0 or from_index >= slots.size() or to_index < 0 or to_index >= slots.size():
		return
	
	var temp_item = slots[from_index].item
	var temp_amount = slots[from_index].amount

	if not slots[to_index]:
		slots[to_index] = ItemSlot.new()
		
	slots[from_index].item = slots[to_index].item
	slots[from_index].amount = slots[to_index].amount
	
	slots[to_index].item = temp_item
	slots[to_index].amount = temp_amount
	
	inventory_changed.emit()

func merge_slots(from_index: int, to_index: int):
	if from_index < 0 or from_index >= slots.size() or to_index < 0 or to_index >= slots.size():
		return
	
	var from_slot = slots[from_index]
	var to_slot = slots[to_index]
	
	if from_slot.is_empty() or to_slot.is_empty():
		return
	
	if from_slot.item.id != to_slot.item.id or to_slot.amount == to_slot.item.max_stack_size:
		swap_slots(from_index, to_index)
		return
	
	var total = from_slot.amount + to_slot.amount
	if total <= from_slot.item.max_stack_size:
		to_slot.amount = total
		from_slot.clear()
	else:
		to_slot.amount = to_slot.item.max_stack_size
		from_slot.amount = total - to_slot.item.max_stack_size
		
	inventory_changed.emit()
