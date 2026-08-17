extends Resource

class_name Inventory

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem) -> bool:
	## Looks for slot that has an item where the amount in the slot is smaller than maxStack
	var itemSlots = slots.filter(func(slot): 
		return slot.item == item && slot.amount < item.maxStack)
	
	## If slot is not empty than add 1
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
		print("reached existing slot add")
		update.emit()
		return true
	## Filter for empty slots and add item and set to 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
			print("reached empty slot set")
			update.emit()
			return true
	return false


	
