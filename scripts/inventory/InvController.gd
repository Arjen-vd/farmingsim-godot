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
	
func canMove(from: InvSlot, to: InvSlot) -> bool:
	if from == to:
		return false
	
	if from.item == null:
		return false
	
	if to.item != null:
		if from.item == to.item && to.amount < to.item.maxStack:
			return true
		return true
	
	return true


func move(from: InvSlot, to: InvSlot) -> void:
	if to.item != null:
		if to.amount + from.amount > to.item.maxStack:
			var freeSpaceLeft : int = to.item.maxStack- to.amount

			from.amount -= freeSpaceLeft
			to.amount += freeSpaceLeft
			update.emit()
		if to.item != from.item:
			var orgToItem = to.item
			var orgToAmount = to.amount
			var orgFromItem = from.item
			var orgFromAmount = from.amount
			
			to.item = orgFromItem
			to.amount = orgFromAmount
			
			from.item = orgToItem
			from.amount = orgToAmount
			update.emit()
	else:
		to.item = from.item
		to.amount += from.amount
	
		from.item = null
		from.amount = 0
		update.emit()
			
