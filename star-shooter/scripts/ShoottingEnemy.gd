extends "res://star-shooter/scripts/Enemy.gd"

signal enemy_spawn_laser(Laser, location)

var enemy_type = 'shootting'
var max_health = 1
var max_speed = 200

func _ready():	
	var difficulty = get_parent().get_difficulty()	
	health = difficulty
	can_shoot = true
	
	if health < max_health: health = difficulty
	else: health = max_health

func _on_TimerToShoot_timeout():
	if can_shoot:		
		emit_signal("enemy_spawn_laser", Laser, global_position)
			
