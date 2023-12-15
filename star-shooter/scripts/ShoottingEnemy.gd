extends "res://star-shooter/scripts/Enemy.gd"

signal enemy_spawn_laser(Laser, location)

var enemy_type = 'shootting'

func _ready():
	health = 2
	can_shoot = true

func _on_TimerToShoot_timeout():
	if can_shoot:		
		emit_signal("enemy_spawn_laser", Laser, global_position)
			
