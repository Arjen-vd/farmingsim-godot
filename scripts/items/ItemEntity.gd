extends Area2D

class_name ItemEntity

@onready var sprite2D: Sprite2D = $Sprite2D

var item : InvItem

func initialize(new_item: InvItem):
	item = new_item
	sprite2D.texture = new_item.texture

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Reached collision entitiy")
	queue_free()
