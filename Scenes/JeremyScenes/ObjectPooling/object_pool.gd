class_name ObjectPool
extends Node 
@export var scene: PackedScene
var object_pool: Array = [] 

func add_to_pool(object: Node2D) -> void:
	object_pool.push_back(object)
	
	#object.global_position = Vector2(9999999, 9999999)
	
	if (object.is_in_group("emu_weak") or object.is_in_group("emu_strong")):
		object.get_node("AttackNode").get_child(0).stop()
	
	object.get_node("Hitbox").set_deferred("monitorable", false)
	object.get_node("Hitbox").set_deferred("monitoring", false)
	
	object.get_node("Hurtbox").set_deferred("monitorable", false)
	object.get_node("Hurtbox").set_deferred("monitoring", false)
	
	object.set_collision_layer_value(8, false)
	object.set_collision_mask_value(8, false)

	
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
		if (object.is_in_group("emu_weak") or object.is_in_group("emu_strong")):
			object.get_node("AttackNode").get_child(0).start()
	
	
	object.get_node("Hitbox").set_deferred("monitorable", true)
	object.get_node("Hitbox").set_deferred("monitoring", true)
	
	object.get_node("Hurtbox").set_deferred("monitorable", true)
	object.get_node("Hurtbox").set_deferred("monitoring", true)
	
	object.set_collision_layer_value(8, true)
	object.set_collision_mask_value(8, true)
	
	object.add_to_group("active_enemy")
	
	object.set_process(true)
	object.set_physics_process(true)
	object.show()
	return object
