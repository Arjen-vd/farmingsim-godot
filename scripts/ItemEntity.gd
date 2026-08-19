extends Area2D

class_name ItemEntity

@onready var sprite2D: Sprite2D = $Sprite2D

var item : ItemData

func initialize(new_item: ItemData):
	item = new_item
	sprite2D.texture = new_item.texture

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.pickUpItemEntity(item):
		queue_free()
