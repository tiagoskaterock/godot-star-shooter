extends Area2D

export (int) var speed = 150
export (int) var health = 3
const type = 'enemy'
export var can_shoot = false
var is_alive = true

var Laser = preload("res://star-shooter/scenes/EnemyLaser.tscn")

func _physics_process(delta):
	if is_alive: global_position.y += speed * delta

func enemy_hit():
	global_position.y -= speed / 10
	$HitFX.play()
	hurt()
	check_health()
	
func enemy_dies():
	is_alive = false
	call_deferred("_disable_collision_shape")
	$DeadFX.play()	
	$TimerToDie.start()
	
func _disable_collision_shape(): $CollisionShape2D.disabled = true

func _on_TimerToDie_timeout(): queue_free()
	
func hurt(): health -= 1

func check_health(): if health < 1: enemy_dies()
