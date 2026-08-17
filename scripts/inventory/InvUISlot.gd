extends Panel

@onready var itemVisual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amountText: Label = $CenterContainer/Panel/Label

var inventorySlot: InvSlot
var inventory: Inventory

func update(new_inventory: Inventory, slot: InvSlot):
	inventory = new_inventory
	inventorySlot = slot
	
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
		"slot": inventorySlot
	}
	
	var preview: TextureRect = TextureRect.new()
	preview.texture = inventorySlot.item.texture
	set_drag_preview(preview)
	
	return data

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var draggedSlot: InvSlot = data["slot"]
	
	return inventory.canMove(draggedSlot, inventorySlot)
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var draggedSlot: InvSlot = data["slot"]
	
	inventory.move(draggedSlot, inventorySlot)
	
		
