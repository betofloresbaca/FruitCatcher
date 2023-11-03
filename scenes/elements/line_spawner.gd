extends Node2D

signal object_spawned

@export_range(0.1, 100, 0.1) var objects_per_seccond: float = 1
@export var spawn_scene : PackedScene
@export var spawn_container_path: NodePath
@export var auto_start: bool = false

var setted_objects_per_seccond: float = 0

var is_spawning = false


func _ready():
	$Internal/SpawnLine.hide()
	if auto_start:
		start()


func _process(delta):
	if not is_spawning:
		return
	if (
		setted_objects_per_seccond != objects_per_seccond
		and objects_per_seccond > 0
	):
		setted_objects_per_seccond = objects_per_seccond
		$Internal/SpawnTimer.stop()
		$Internal/SpawnTimer.wait_time = 1 / setted_objects_per_seccond
		$Internal/SpawnTimer.start()


func _on_falling_timer_timeout():
	__spawn()


func start(objs_per_seccond = objects_per_seccond):
	objects_per_seccond = objs_per_seccond
	is_spawning = true
	__spawn()


func stop():
	is_spawning = false
	$Internal/SpawnTimer.stop()


func __spawn():
	var spawn_position = __get_random_spawn_position()
	var spawn_object = spawn_scene.instantiate()
	get_node(spawn_container_path).add_child(spawn_object)
	spawn_object.set_position(spawn_position)
	object_spawned.emit(spawn_object)


func __get_random_spawn_position():
	var start = to_global($Internal/SpawnLine.points[0])
	var end = to_global($Internal/SpawnLine.points[1])
	var spawn_vector = end - start
	var spawn_percent = randf()
	return spawn_vector * spawn_percent + start



