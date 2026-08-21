extends CharacterBody2D

@export var speed : float = 75.0

@export var inventoryManager : InventoryManager
@export var playerData : PlayerData
@onready var audioStreamPlayer: AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D


func _ready() -> void:
	inventoryManager.printContents()

func _physics_process(delta: float) -> void:
	## Get Input direction on a 2d vector
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	## Calculate velocity
	velocity = input_direction * speed
		
	## Debug inventory management	
	if Input.is_action_just_pressed("Inventory"):
		inventoryManager.printContents()
		
	if Input.is_action_just_pressed("Space"):
		inventoryManager.clearInventory()

	if Input.is_action_just_pressed("PrintStats"):
		printPlayerStats()

	move_and_slide()
	
func pickUpItemEntity(item : ItemData) -> bool:
	if inventoryManager.pickUpItem(item):
		audioStreamPlayer.play()
		return true
	else:
		return false
		
func printPlayerStats() -> void:
	print(
		"Health: " + str(playerData.Health) + "\n",
		"Stamina: " + str(playerData.Stamina) + "\n",
		"Money: " + str(playerData.Money) + "\n"
	)
	
