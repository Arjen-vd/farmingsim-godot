extends Area2D

class_name ItemEntity

@onready var sprite2D: Sprite2D = $Sprite2D

var item : InventoryItem

func initialize(new_item: InventoryItem):
	item = new_item
	sprite2D.texture = new_item.icon

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Reached collision entitiy")
	queue_free()
