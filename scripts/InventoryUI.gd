extends Control

@export var inventoryManager : InventoryManager
@onready var slots: Array = $Inventory.get_children()

var isOpen : bool = false

func _ready() -> void:
	inventoryManager.inventoryData.update.connect(update_slots)
	update_slots()
	close()
		
func update_slots():
	print("UPDATE UI")

	var inventory = inventoryManager.inventoryData
	
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(
		inventory,
		inventory.slots[i],
		i,
		inventoryManager
	)

func openInventory() -> void:
	if isOpen:
		close()
	else:
		open()
	
func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false
