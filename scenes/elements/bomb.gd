extends Node2D

const gravity = 500
const max_speed = 200
const max_angle_velocity = 8
const min_angle_velocity = -8

var velocity = Vector2.ZERO
var angle_velocity = randf_range(min_angle_velocity, max_angle_velocity)
var falling = true

func _process(delta):
	if falling:
		# To fall
		velocity.y += gravity * delta
		velocity.y = clamp(velocity.y, 0, max_speed)
		position.y += velocity.y * delta
		# Rotate
		rotation += angle_velocity * delta
	else:
		velocity = Vector2.ZERO


func _on_area_2d_body_entered(body):
	falling = false
	$ExplodeAnimationPlayer.play("explode")


func _on_explossion_animated_sprite_2d_animation_finished():
	queue_free()


func _on_explossion_area_2d_body_entered(body):
	body.kill()
