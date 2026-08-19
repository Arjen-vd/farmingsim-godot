extends Resource

class_name InventoryManager

@export var inventory : Inventory

func moveItem(fromInventory : Inventory,fromIndex : int,
				toInventory : Inventory,toIndex : int):
	var fromSlot = fromInventory.slots[fromIndex]
	var toSlot = toInventory.slots[toIndex]
	
	toSlot.item = fromSlot.item
	toSlot.amount = fromSlot.amount

	fromSlot.item = null
	fromSlot.amount = 0

#func additem()
	
func clearInventory():
	for i in inventory.slots:
		i.item = null
		i.amount = 0
		
func printContents():
	for i in inventory.slots:
		if i.item != null:
			print(str(i.item.name) + " " + str(i.amount))
		else:
			print("Empty Slot")
