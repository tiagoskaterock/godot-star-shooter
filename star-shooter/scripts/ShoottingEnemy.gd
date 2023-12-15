extends "res://star-shooter/scripts/Enemy.gd"

signal enemy_spawn_laser(Laser, location)

func _ready():
	can_shoot = true

func _on_TimerToShoot_timeout():
	if can_shoot:		
		emit_signal("enemy_spawn_laser", Laser, global_position)
			
