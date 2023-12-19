extends "res://star-shooter/scripts/Enemy.gd"

var enemy_type = 'normal'
var max_health = 2
var max_speed = 500
var difficulty

func _ready():	
	difficulty = get_parent().get_difficulty()
	health = difficulty
	
	if health < max_health: health = difficulty
	else: health = max_health
	
func _process(delta):
	if speed < max_speed: speed *= difficulty
	else: speed = max_speed
	
