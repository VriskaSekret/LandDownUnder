class_name ObjectPool
extends Node 
@export var scene: PackedScene
var object_pool: Array = [] 

func add_to_pool(object: Node2D) -> void:
	object_pool.push_back(object)
	
	object.get_node("Hitbox").set_deferred("monitorable", false)
	object.get_node("Hitbox").set_deferred("monitoring", false)
	object.get_node("Hurtbox").set_deferred("monitorable", false)
	object.get_node("Hurtbox").set_deferred("monitoring", false)
	object.remove_from_group("active_enemy")
	
	object.set_process(false)
	object.set_physics_process(false)
	object.hide() 

func pull_from_pool() -> Node2D:
	var object: Node2D
	if object_pool.is_empty():
		object = scene.instantiate()
	else:
		object = object_pool.pop_back()
	
	object.get_node("Hitbox").set_deferred("monitorable", true)
	object.get_node("Hitbox").set_deferred("monitoring", true)
	
	object.get_node("Hurtbox").set_deferred("monitorable", true)
	object.get_node("Hurtbox").set_deferred("monitoring", true)
	object.add_to_group("active_enemy")
	
	object.set_process(true)
	object.set_physics_process(true)
	object.show()
	return object
