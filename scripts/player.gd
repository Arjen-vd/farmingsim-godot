extends CharacterBody2D


const SPEED = 75.0


func _physics_process(delta: float) -> void:
	var direction_x := Input.get_axis("Left", "Right")
	var direction_y := Input.get_axis("Up", "Down")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	print("x: " + str(velocity.x) + " y: " + str(velocity.y))

	move_and_slide()
