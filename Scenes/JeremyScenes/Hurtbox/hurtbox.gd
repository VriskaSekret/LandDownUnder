extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var HurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage, angle, knockback)

var hit_once_arr = []

func _on_area_entered(area):
	if area.is_in_group("Attack"):
		if not area.get("damage") == null:
			match HurtBoxType:
				0: #Cooldown
					collision.call_deferred("set", "disabled", true)
					disable_timer.start()
				1: #HitOnce
					if hit_once_arr.has(area) == false:
						hit_once_arr.append(area)
						if area.has_signal("remove_from_arr"):
							if not area.is_connected("remove_from_arr", Callable(self, "remove_from_list")):
								area.connect("remove_from_arr", Callable(self, "remove_from_list"))
					else:
						return
				2: #DisableHitBox
					if area.has_method("temp_disable"):
						area.temp_disable()
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knockback = area.knockback_amount
			
			emit_signal("hurt", damage, angle, knockback)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)

func remove_from_list(obj):
	if hit_once_arr.has(obj):
		hit_once_arr.erase(obj)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
