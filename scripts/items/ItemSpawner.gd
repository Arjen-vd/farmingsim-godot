extends Area2D

var itemEntity = preload("res://scenes/ItemEntity.tscn")
var appleResource = preload("res://resources/items/apple.tres")
var swordResource = preload("res://resources/items/sword.tres")

@onready var timer: Timer = $Timer

func _ready():
	timer.start()

func _on_timer_timeout() -> void:
	var resource = random_resource()
	spawn_item(resource, Vector2(randi_range(-20,20), randi_range(-20,20)))
	
	
func spawn_item(item: InventoryItem, spawnPosition: Vector2):
	var entity = itemEntity.instantiate()
	
	add_child(entity)
	
	entity.initialize(item)
	entity.position = spawnPosition
	
func random_resource():
	var chance : int = randi_range(1,100)
	if chance > 50:
		return appleResource
	else:
		return swordResource
	
