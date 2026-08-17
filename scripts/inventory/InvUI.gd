extends Control

@onready var inventory: Inventory = preload("res://resources/inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var isOpen : bool = false

func _ready() -> void:
	inventory.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory, inventory.slots[i])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
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
