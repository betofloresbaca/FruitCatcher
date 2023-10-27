extends Node2D

const gravity = 500
const max_speed = 200
const max_angle_velocity = 8
const min_angle_velocity = -8

var velocity = Vector2.ZERO
var angle_velocity = randf_range(min_angle_velocity, max_angle_velocity)


func _ready():
	var sprite_frames = $AnimatedSprite2D.sprite_frames.get_frame_count(
		"default"
	)
	var frame = randi() % sprite_frames
	$AnimatedSprite2D.frame = frame


func _process(delta):
	# To fall
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, 0, max_speed)
	position.y += velocity.y * delta
	# Rotate
	rotation += angle_velocity * delta


func _on_pick_area_body_entered(other_body: Node2D):
	if other_body.is_in_group("player"):
		other_body.point_up()
	elif other_body.is_in_group("ground"):
		pass
	queue_free()
