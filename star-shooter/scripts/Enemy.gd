extends Area2D

export (int) var speed = 150
export (int) var health = 3
const type = 'enemy'
export var can_shoot = false
var is_alive = true
var is_blinking = false
var is_flashing = false
var red_state = false

var Laser = preload("res://star-shooter/scenes/EnemyLaser.tscn")

func _ready():
	pass

func _physics_process(delta):
	check_is_is_flashing()
	check_if_is_blinking()
	if is_alive: global_position.y += speed * delta
	else: $Sprite.visible = false

func check_if_is_blinking():
	if is_blinking and is_alive: $Sprite.visible = ! $Sprite.visible
	else: $Sprite.visible = true

func check_is_is_flashing():		
	if is_flashing and is_alive:
		if red_state: 
			sprite_turns_red()
			red_state = false
		else: 
			sprite_turns_normal()
			red_state = true
	elif is_alive: sprite_turns_normal()
		
func sprite_turns_red(): $Sprite.modulate = Color(1, 0, 0, 1)

func sprite_turns_normal(): $Sprite.modulate = Color(1, 1, 1, 1)			

func enemy_hit():
	is_flashing = true
	$TimerToStopFlashing.start()
	global_position.y -= speed / 10
	$HitFX.play()
	hurt()
	check_health()
	
func _on_TimerToStopFlashing_timeout(): is_flashing = false	
	
func enemy_dies():	
	is_alive = false
	$Sprite.visible = false
	$Explosion.start()
	is_flashing = false	
	is_blinking = false
#	sprite_turns_red()
	call_deferred("_disable_collision_shape")
#	$DeadFX.play()
	$TimerToDie.start()
	
func _disable_collision_shape(): $CollisionShape2D.disabled = true

func _on_TimerToDie_timeout(): queue_free()
	
func hurt(): health -= 1

func check_health(): if health < 1: enemy_dies()
