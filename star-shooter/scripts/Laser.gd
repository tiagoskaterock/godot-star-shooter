extends Area2D

var speed = 700
var vertical_direction
export var type = 'player_laser'
export (int) var damage = 1

func _ready():
	if type == 'player_laser': vertical_direction = -1
	elif type == 'enemy_laser': vertical_direction = 1

func _physics_process(delta):
	global_position.y += speed * vertical_direction * delta
	
func _on_Laser_area_entered(area):	
	check_is_player_laser_hits_enemy(area)
	if type == 'enemy_laser' and area.type == "player_laser":
		laser_hit()
	if type == 'player_laser' and area.type == 'enemy_laser':		
		laser_hit()
	if area.type == 'player' and type != 'player_laser':
		area.get_parent().lose_life()
		laser_hit()
		
func check_is_player_laser_hits_enemy(area):
	if type == 'player_laser' and area.type == 'enemy':
		get_parent().get_child(1).add_points(100)
		area.enemy_hit()
		queue_free()
		
func play_laser_fx_01():
	$LaserFX_01.play()
		
func laser_hit():
	speed = 0
	$Sprite.visible = false
	$DeadFX.play()
	$TimerToDie.start()		

func _on_TimerToDie_timeout():
	queue_free()
