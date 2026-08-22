extends Area2D

var itemEntity = preload("res://scenes/ItemEntity.tscn")
var appleResource = preload("res://resources/items/apple.tres")
@export var inventoryManager : InventoryManager

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	spawnItem(appleResource, Vector2(randi_range(-20,20), randi_range(-20,20)))

func spawnItem(item: ItemData, spawnPosition: Vector2):
	var entity = itemEntity.instantiate()
	add_child(entity)
	
	entity.initialize(item)
	entity.position = spawnPosition
	
func _on_area_entered(area: Area2D) -> void:
	timer.start()
	print("Entered")
	
func _on_area_exited(area: Area2D) -> void:
	timer.stop()
	print("Exited")
