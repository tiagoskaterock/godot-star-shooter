extends Area2D

export (int) var speed = 150
export (int) var health = 3
const type = 'enemy'

func _physics_process(delta):
	global_position.y += speed * delta

func enemy_hit():
	$HitFX.play()
	health -= 1
	print('enemy health: ' + str(health))
	if health < 1: 
		print('morre porra')
		enemy_dies()
	
func enemy_dies():
	$DeadFX.play()
	$Sprite.visible = false
	$TimerToDie.start()

func _on_TimerToDie_timeout():
	queue_free()
