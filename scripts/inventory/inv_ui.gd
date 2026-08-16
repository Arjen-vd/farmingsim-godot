extends Control

@onready var inv: Inventory = preload("res://resources/inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open : bool = false

func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Inventory"):
		if is_open:
			close()
		else:
			open()
	
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
