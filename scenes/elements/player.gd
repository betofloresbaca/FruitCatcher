extends CharacterBody2D

const acceleration = 2000
const max_speed = 400
const drag = 1500


func _process(delta):
	var input_vector = get_input_vector()
	velocity += input_vector * acceleration * delta
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	if input_vector == Vector2.ZERO and abs(velocity.x) > 0:
		velocity.x -= sign(velocity.x) * clamp(drag * delta, 0, abs(velocity.x))
	move_and_slide()


func get_input_vector():
	var movement = Vector2.ZERO
	if Input.is_action_pressed("Left"):
		movement = movement + Vector2.LEFT
	if Input.is_action_pressed("Right"):
		movement = movement + Vector2.RIGHT
	return movement
