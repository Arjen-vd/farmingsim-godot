extends CharacterBody2D

@export var speed : float = 75.0

@export var inventoryManager : InventoryManager

const APPLE = preload("res://resources/items/Apple.tres")

func _ready() -> void:
	inventoryManager.printContents()

func _physics_process(delta: float) -> void:
	## Get Input direction on a 2d vector
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	## Calculate velocity
	velocity = input_direction * speed
		
	if Input.is_action_just_pressed("Inventory"):
		inventoryManager.printContents()
		
	if Input.is_action_just_pressed("Space"):
		inventoryManager.clearInventory()
		
	if Input.is_action_just_pressed("AddApple"):
		print(inventoryManager.addItem(APPLE, 5))

	move_and_slide()
	
func pickUpItemEntity(item : ItemData) -> bool:
	return inventoryManager.pickUpItem(item)
