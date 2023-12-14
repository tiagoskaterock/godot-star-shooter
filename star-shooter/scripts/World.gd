extends Node2D

func _physics_process(delta):
	pass

func _on_Player_spawn_laser(Laser, location):
	var laser = Laser.instance()
	add_child(laser)
	laser.play_laser_fx_01()
	laser.global_position = location

func _on_ShoottingEnemy_enemy_spawn_laser(Laser, location):
	var laser = Laser.instance()
	add_child(laser)
	laser.play_laser_fx_01()
	laser.global_position = location
