extends Area2D

export (int) var speed = 150
export (int) var health = 3
const type = 'enemy'

func _physics_process(delta):
	global_position.y += speed * delta

func enemy_hit():
	$HitFX.play()
	hurt()
	check_health()
	
func enemy_dies():
	$DeadFX.play()
	hide_enemy()
	$TimerToDie.start()

func _on_TimerToDie_timeout(): queue_free()
	
func hurt(): health -= 1

func check_health(): if health < 1: enemy_dies()

func hide_enemy(): visible = false
	
