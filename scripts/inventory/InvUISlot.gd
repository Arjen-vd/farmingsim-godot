extends Panel

@onready var itemVisual: Sprite2D = $CenterContainer/Panel/item_display
@onready var amountText: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot.item:
		itemVisual.visible = false
		amountText.visible = false
	else:
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		amountText.visible = true
		amountText.text = str(slot.amount)
