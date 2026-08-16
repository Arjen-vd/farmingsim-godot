extends CharacterBody2D


const SPEED = 75.0


func _physics_process(delta: float) -> void:
	## Get Input direction on a 2d vector
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	## Calculate velocity
	velocity = input_direction * SPEED
		
	## Debug
	print("x: " + str(round(position.x)) + " y: " + str(round(position.y)))

	move_and_slide()
