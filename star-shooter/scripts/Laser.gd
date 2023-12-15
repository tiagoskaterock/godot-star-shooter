extends Area2D

var speed
var vertical_direction
export var type = 'player_laser'
export (int) var damage = 1
var points_added_by_hit = 75
var points_added_by_diver_enemy = 200
var points_added_by_normal_enemy = 50
var enemy_laser_speed = 700
var player_laser_speed = 2000

func _ready():
	check_speed()
	check_direction()

func _physics_process(delta):
	move_laser(delta)
	
func check_speed():
	if type == 'player_laser': speed = player_laser_speed
	elif type == 'enemy_laser': speed = enemy_laser_speed
	
func move_laser(delta):
	global_position.y += speed * vertical_direction * delta
	
func check_direction():
	if type == 'player_laser': vertical_direction = -1
	elif type == 'enemy_laser': vertical_direction = 1
	
func _on_Laser_area_entered(area):
	check_if_player_laser_hits_enemy(area)
	check_if_laser_hits_player(area)
	check_is_player_laser_hits_enemy_laser(area)
	if type == 'player_laser' and area.type == 'enemy_laser':
		laser_hit()
		
func check_is_player_laser_hits_enemy_laser(area):	
	if type == 'enemy_laser' and area.type == "player_laser":
		laser_hit()
	
func check_if_laser_hits_player(area):
	if area.type == 'player' and type != 'player_laser':
		var player = area.get_parent()
		if player.visible:
			player.player_die()
			laser_hit()
		
func check_if_player_laser_hits_enemy(area):
	if type == 'player_laser' and area.type == 'enemy':
		add_points_by_enemy(area)
		area.enemy_hit()
		queue_free()
		
func add_points_by_enemy(area):
	var points_added = points_added_by_hit
	var player = get_parent().get_node('Player')
	var enemy = area.enemy_type
	if enemy == 'diver':
		points_added = points_added_by_diver_enemy
	elif enemy == 'normal':
		points_added = points_added_by_normal_enemy
	player.add_points(points_added)
		
func play_laser_fx_01():
	$LaserFX_01.play()
	
func laser_hit():
	speed = 0	
	$Sprite.visible = false
	call_deferred('_disable_collision_shape')
	$DeadFX.play()
	$TimerToDie.start()
	
func _disable_collision_shape():
	$CollisionShape2D.disabled = true

func _on_TimerToDie_timeout():
	queue_free()
