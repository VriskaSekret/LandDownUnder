extends Node 

@export var scene: PackedScene
var object_pool: Array = [] 

func add_to_pool(object: Node2D) -> void:
	object_pool.push_back(object)

	object.target = null
	
	object.global_position = Vector2(9999999, 9999999)
	object.set_process(false)
	object.set_physics_process(false)
	object.hide()

func pull_from_pool() -> Node2D:
	var object: Node2D
	if object_pool.is_empty():
		object = scene.instantiate() #creates explosion
	else:
		object = object_pool.pop_back() # doesn't create explosion

	
	object.set_process(true)
	object.set_physics_process(true)
	object.show()
	
	object.get_node("AnimationPlayer").play("spawn_explosion")
	
	object.get_node("ExplosionSound").play()
	
	return object
