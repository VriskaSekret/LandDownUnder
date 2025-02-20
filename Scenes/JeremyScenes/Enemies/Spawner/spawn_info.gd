extends Resource

class_name Spawn_info

@export var time_start:int
@export var time_end:int
@export var enemy: enemies
@export var enemy_num:int
@export var enemy_spawn_delay:int

enum enemies {
	KANGA_WEAK,
	KANGA_STRONG,
	EMU_WEAK,
	EMU_STRONG,
	MAGPIE
}

var spawn_delay_counter = 1
