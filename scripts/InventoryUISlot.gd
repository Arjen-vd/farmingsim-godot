extends Panel

@onready var itemVisual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amountText: Label = $CenterContainer/Panel/Label

var inventorySlot: InventorySlot
var inventory: Inventory
var slotIndex: int
var inventoryManager: InventoryManager


func update(
		new_inventory: Inventory,
		slot: InventorySlot,
		index: int,
		manager: InventoryManager
	):
	print("SLOT UPDATE: ", index, " / ", slot.item, " / ", slot.amount)

	inventory = new_inventory
	inventorySlot = slot
	slotIndex = index
	inventoryManager = manager
	
	if !slot.item:
		itemVisual.visible = false
		amountText.visible = false
	else:
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		amountText.visible = true
		amountText.text = str(slot.amount)


func _get_drag_data(at_position: Vector2) -> Variant:
	if inventorySlot.item == null:
		return null
	
	var data = {
		"inventory": inventory,
		"index": slotIndex
	}
	
	var preview: TextureRect = TextureRect.new()
	preview.texture = inventorySlot.item.texture
	set_drag_preview(preview)
	
	return data


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var draggedInventory: Inventory = data["inventory"]
	var draggedIndex: int = data["index"]
	
	return inventoryManager.canMove(
		draggedInventory,
		draggedIndex,
		inventory,
		slotIndex
	)


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var draggedInventory: Inventory = data["inventory"]
	var draggedIndex: int = data["index"]
	
	inventoryManager.moveItem(
		draggedInventory,
		draggedIndex,
		inventory,
		slotIndex
	)
