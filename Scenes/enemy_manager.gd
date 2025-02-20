extends Node2D

@onready var kanga_weak: Node = $Pools/KangaWeak
@onready var kanga_strong: Node = $Pools/KangaStrong
@onready var emu_weak: Node = $Pools/EmuWeak
@onready var emu_strong: Node = $Pools/EmuStrong

@onready var enemy_spawner: Node2D = $EnemySpawner

const MAGPIE = preload("res://Scenes/JeremyScenes/Enemies/Magpie/magpie.tscn")

var enemy_types = Spawn_info.enemies

func get_enemy(enemy_type):
	if enemy_type == enemy_types["KANGA_WEAK"]:
		#print("kanga weak")
		return kanga_weak.pull_from_pool()
	elif enemy_type == enemy_types["KANGA_STRONG"]:
		#print("kanga strong")
		return kanga_strong.pull_from_pool()
	elif enemy_type == enemy_types["EMU_WEAK"]:
		#print("emu weak")
		return emu_weak.pull_from_pool()
	elif enemy_type == enemy_types["EMU_STRONG"]:
		#print("emu strong")
		return emu_strong.pull_from_pool()
	elif enemy_type == enemy_types["MAGPIE"]:
		#print("magpie")
		return MAGPIE.instantiate()

func remove_enemy(enemy):
	if enemy.is_in_group("kanga_weak"):
		#print("kanga weak")
		return kanga_weak.add_to_pool(enemy)
	elif enemy.is_in_group("kanga_strong"):
		#print("kanga strong")
		return kanga_strong.add_to_pool(enemy)
	elif enemy.is_in_group("emu_weak"):
		#print("emu weak")
		return emu_weak.add_to_pool(enemy)
	elif enemy.is_in_group("emu_strong"):
		#print("emu strong")
		return emu_strong.add_to_pool(enemy)
