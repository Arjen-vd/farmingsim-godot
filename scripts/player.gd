extends CharacterBody2D


@export var speed : float = 75.0

@export var inventory: Inventory

@export var testitem: InvItem

func _physics_process(delta: float) -> void:
	## Get Input direction on a 2d vector
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_just_pressed("Space"):
		inventory.insert(testitem)
	
	## Calculate velocity
	velocity = input_direction * speed
		
	## Debug
	print("x: " + str(round(position.x)) + " y: " + str(round(position.y)))

	move_and_slide()

func collect(item):
	inventory.insert(item)
