extends Node2D

@export var color: Color

const gravity = 150
const max_speed = 200

var velocity = Vector2.ZERO


func _ready():
	$ColorRect.color = color


func _process(delta):
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, 0, max_speed)
	position.y += velocity.y * delta


func _on_pick_area_body_entered(other_body: Node2D):
	if other_body.is_in_group("player"):
		pass
	elif other_body.is_in_group("ground"):
		pass
	queue_free()
