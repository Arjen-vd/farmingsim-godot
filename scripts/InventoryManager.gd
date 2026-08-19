extends Resource

class_name InventoryManager

@export var inventory : Inventory

func moveItem(fromInventory : Inventory,fromIndex : int,
				toInventory : Inventory,toIndex : int) -> void:
	var fromSlot = fromInventory.slots[fromIndex]
	var toSlot = toInventory.slots[toIndex]
	
	toSlot.item = fromSlot.item
	toSlot.amount = fromSlot.amount

	fromSlot.item = null
	fromSlot.amount = 0

func addItem(item : ItemData, amount : int) -> int:
	while amount > 0:
		## Filter array slots that have an item and where amount is less than maxStack
		var stackSlots = inventory.slots.filter(func(slot):
			return slot.item == item and slot.amount < item.maxStack
		)

		## If there are slots available pick the first one and add item
		if !stackSlots.is_empty():
			var slot = stackSlots[0]
			var freeSpace = item.maxStack - slot.amount
			## Takes the smallest amount
			var amountToAdd = min(amount, freeSpace)

			slot.amount += amountToAdd
			amount -= amountToAdd
			continue
		
		## Filter empty slots (Item == null)
		var emptySlots = inventory.slots.filter(func(slot):
			return slot.item == null
		)

		## There are no empty slots left. Inv full
		if emptySlots.is_empty():
			print("Inventory full")
			break

		var slot = emptySlots[0]
		var amountToAdd = min(amount, item.maxStack)

		slot.item = item
		slot.amount = amountToAdd
		amount -= amountToAdd
	return amount
			
func pickUpItem(item : ItemData) -> bool:
	if addItem(item, 1) > 0:
		return false
	return true
	
func clearInventory():
	for i in inventory.slots:
		i.item = null
		i.amount = 0
		
func printContents():
	print("Inventory:")
	for i in inventory.slots:
		if i.item != null:
			print(str(i.item.name) + " " + str(i.amount))
		else:
			print("Empty Slot")
	print("-----------------" + "\n")
