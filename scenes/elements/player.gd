extends CharacterBody2D

const speed = 400


func _ready():
	pass  # Replace with function body.


func _process(delta):
	var movement = get_input_vector()
	velocity = movement * speed
	move_and_slide()


func get_input_vector():
	var movement = Vector2.ZERO
	if Input.is_action_pressed("Left"):
		movement = movement + Vector2.LEFT
	if Input.is_action_pressed("Right"):
		movement = movement + Vector2.RIGHT
	return movement
