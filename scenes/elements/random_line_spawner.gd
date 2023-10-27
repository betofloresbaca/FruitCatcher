extends Node2D

signal object_spawned

@export_range(0.1, 100, 0.1) var objects_per_seccond: float = 1
@export var spawn_container_path: NodePath

var setted_objects_per_seccond: float = 0

var template_nodes = []


func _ready():
	$Internal/SpawnLine.hide()
	template_nodes = __get_spawn_nodes()
	for node in template_nodes:
		node.hide()
		node.process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta):
	if (
		setted_objects_per_seccond != objects_per_seccond
		and objects_per_seccond > 0
	):
		setted_objects_per_seccond = objects_per_seccond
		$Internal/SpawnTimer.stop()
		$Internal/SpawnTimer.wait_time = 1 / setted_objects_per_seccond
		$Internal/SpawnTimer.start()


func _on_falling_timer_timeout():
	var spawn_position = __get_random_spawn_position()
	template_nodes.shuffle()
	var spawn_object = template_nodes[0].duplicate()
	get_node(spawn_container_path).add_child(spawn_object)
	spawn_object.set_position(spawn_position)
	spawn_object.process_mode = Node.PROCESS_MODE_INHERIT
	spawn_object.show()
	object_spawned.emit()


func __get_random_spawn_position():
	var start = to_global($Internal/SpawnLine.points[0])
	var end = to_global($Internal/SpawnLine.points[1])
	var spawn_vector = end - start
	var spawn_percent = randf()
	return spawn_vector * spawn_percent + start


func __get_spawn_nodes():
	var node = Node.new()
	node.duplicate()
	var nodes = []
	for child in get_children():
		if child.name == "Internal":
			continue
		nodes.push_back(child)
	return nodes
