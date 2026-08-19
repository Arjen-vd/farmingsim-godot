extends Resource

class_name InventoryManager

@export var inventory : Inventory

func canMove(fromInventory : Inventory, fromIndex : int,
		toInventory : Inventory, toIndex : int) -> bool:
	
	var fromSlot = fromInventory.slots[fromIndex]
	var toSlot = toInventory.slots[toIndex]
	
	if fromSlot == toSlot:
		return false
	
	if fromSlot.item == null:
		return false
	
	if toSlot.item == null:
		return true
	
	if toSlot.item == fromSlot.item:
		return toSlot.amount < toSlot.item.maxStack
	
	return true
		
	
func moveItem(fromInventory : Inventory, fromIndex : int,
		toInventory : Inventory, toIndex : int) -> void:
	
	if not canMove(fromInventory, fromIndex, toInventory, toIndex):
		return
	
	var fromSlot = fromInventory.slots[fromIndex]
	var toSlot = toInventory.slots[toIndex]
	
	## Empty slot set item to from item and amount to from amount. Set from item to null and amount to 0.
	if toSlot.item == null:
		toSlot.item = fromSlot.item
		toSlot.amount = fromSlot.amount
		
		fromSlot.item = null
		fromSlot.amount = 0
		fromInventory.update.emit()
		toInventory.update.emit()
	
	## Same item stack it together
	elif toSlot.item == fromSlot.item:
		var freeSpace = toSlot.item.maxStack - toSlot.amount
		var amountToMove = min(fromSlot.amount, freeSpace)
		
		toSlot.amount += amountToMove
		fromSlot.amount -= amountToMove
		fromInventory.update.emit()
		toInventory.update.emit()
		
		if fromSlot.amount == 0:
			fromSlot.item = null
			fromInventory.update.emit()
			toInventory.update.emit()
	
	## Different item swap it
	else:
		var tempItem = toSlot.item
		var tempAmount = toSlot.amount
		
		toSlot.item = fromSlot.item
		toSlot.amount = fromSlot.amount
		
		fromSlot.item = tempItem
		fromSlot.amount = tempAmount
		fromInventory.update.emit()
		toInventory.update.emit()

func addItem(item : ItemData, amount : int) -> int:
	while amount > 0:
		## Filter array slots that have an item and where amount is less than maxStack
		var stackSlots = inventory.slots.filter(func(itemSlot):
			return itemSlot.item == item and itemSlot.amount < item.maxStack
		)

		## If there are slots available pick the first one and add item
		if !stackSlots.is_empty():
			var itemSlot = stackSlots[0]
			var freeSpace = item.maxStack - itemSlot.amount
			## Takes the smallest amount
			@warning_ignore("confusable_local_declaration")
			var amountToAdd = min(amount, freeSpace)

			itemSlot.amount += amountToAdd
			amount -= amountToAdd
			inventory.update.emit()
			continue
		
		## Filter empty slots (Item == null)
		var emptySlots = inventory.slots.filter(func(emptySlot):
			return emptySlot.item == null
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
		inventory.update.emit()

	return amount
			
func pickUpItem(item : ItemData) -> bool:
	if addItem(item, 1) > 0:
		return false
	return true
	
func clearInventory():
	for i in inventory.slots:
		i.item = null
		i.amount = 0
		inventory.update.emit()

		
func printContents():
	print("Inventory:")
	for i in inventory.slots:
		if i.item != null:
			print(str(i.item.name) + " " + str(i.amount))
		else:
			print("Empty Slot")
	print("-----------------" + "\n")
