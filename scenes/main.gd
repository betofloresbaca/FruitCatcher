extends Node2D

@export var ready_scene: PackedScene

const fruits_to_spawn: int = 100
const difficulty_map = [[0, 0.5], [10, 1], [30, 2], [50, 3], [75, 4], [95, 5]]

var score: int = 0
var difficulty_index: int = 0
var fruits_spawned_counter: int = 0
var fruits_killed_counter: int = 0


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


func _on_fruit_spawner_object_spawned(fruit):
	fruit.tree_exited.connect(self._on_fruit_tree_exited)
	fruits_spawned_counter += 1
	if fruits_spawned_counter >= fruits_to_spawn:
		$FruitSpawner.stop()
	elif (
		difficulty_index < difficulty_map.size() - 1
		and fruits_spawned_counter >= difficulty_map[difficulty_index + 1][0]
	):
		difficulty_index += 1
		$FruitSpawner.objects_per_seccond = difficulty_map[difficulty_index][1]


func _on_fruit_tree_exited():
	fruits_killed_counter += 1
	if fruits_killed_counter >= fruits_to_spawn:
		print("Game Over WIN Screen")


func _on_player_fruit_catched():
	score += 1
	$HUD.set_fruit_bar(score)
