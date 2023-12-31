extends CharacterBody2D

const acceleration = 2000
const max_speed = 450
const drag = 2500

signal fruit_catched


func _process(delta):
	var input_vector = get_input_vector()
	velocity += input_vector * acceleration * delta
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	# Drag
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


func point_up():
	fruit_catched.emit()


func kill():
	print("Death")
