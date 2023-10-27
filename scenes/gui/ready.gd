extends Control

signal ready_finished


func _on_animation_player_animation_finished(anim_name):
	ready_finished.emit()
	queue_free()
