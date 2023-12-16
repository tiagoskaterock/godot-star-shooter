extends "res://star-shooter/scripts/Enemy.gd"

const accel = 20
var enemy_type = 'diver'

func _ready():
	health = 1	
	
func _physics_process(delta):	
	accel_diver_enemy()
	
func accel_diver_enemy():
	speed += accel

