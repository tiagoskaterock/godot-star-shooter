extends Node2D

func _on_Player_spawn_laser(Laser, location):
	var laser = Laser.instance()
	add_child(laser)
	laser.play_laser_fx_01()
	laser.global_position = location
