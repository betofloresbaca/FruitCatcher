extends Node2D

@export var ready_scene: PackedScene


func _ready():
	show_ready_scene()


func show_ready_scene():
	var scene = ready_scene.instantiate()
	scene.position = Vector2.ZERO
	scene.ready_finished.connect(self._on_ready_finished)
	add_child(scene)
	get_tree().paused = true


func _on_ready_finished():
	get_tree().paused = false
