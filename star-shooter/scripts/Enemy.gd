extends Area2D

export (int) var speed = 150
export (int) var health = 3
const type = 'enemy'

func _physics_process(delta):
	global_position.y += speed * delta

func enemy_hit():
	health -= 1
	print('enemy health: ' + str(health))
	if health < 1: enemy_dies()
	
func enemy_dies():
	queue_free()
