extends KinematicBody2D

export (int) var max_speed = 500
var acceleration = 2000
var deacceleration = acceleration / 2
var input = Vector2.ZERO
var min_speed_to_move = 15
var intitial_position = Vector2(256, 872)
const max_lives = 5
const start_lives = 2
var lives = start_lives
var points = 0
var type = 'player'
var Laser = preload("res://star-shooter/scenes/PlayerLaser.tscn")
signal spawn_laser(Laser, location)
onready var muzzle = $Muzzle
var is_blinking = false
var is_dead = false

func _physics_process(delta):
	check_if_is_blinking()
	check_min_speed()
	check_move(delta)
	check_shoot()
	limit_on_screen()
	if is_dead: $Sprite.visible = false
	move_and_slide(input)
	
func check_if_is_blinking():
	if is_blinking: $Sprite.visible = !$Sprite.visible
	else: $Sprite.visible = true
	
func limit_on_screen():
	global_position.x = clamp(global_position.x, 50, 490)
	global_position.y = clamp(global_position.y, 40, 920)
	
func check_min_speed():
	if input.y < min_speed_to_move and input.y > -min_speed_to_move: 
		input.y = 0
	if input.x < min_speed_to_move and input.x > -min_speed_to_move: 
		input.x = 0
	
func check_move(delta):
	check_horizontal_move(delta)
	check_vertical_move(delta)
	
func check_horizontal_move(delta):
	if Input.is_action_pressed("move_left") and input.x > -max_speed:
		go_left(delta)
	if Input.is_action_pressed("move_right") and input.x < max_speed:
		go_right(delta)
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		deaccelerate_horizontal(delta)
	if ! Input.is_action_pressed("move_left") and ! Input.is_action_pressed("move_right"):
		deaccelerate_horizontal(delta)

func check_vertical_move(delta):
	if Input.is_action_pressed("move_up") and input.y > -max_speed:
		go_up(delta)
	if Input.is_action_pressed("move_down") and input.y < max_speed:
		go_down(delta)
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_up"):
		deaccelerate_vertical(delta)
	if ! Input.is_action_pressed("move_down") and ! Input.is_action_pressed("move_up"):
		deaccelerate_vertical(delta)
	if input.y > max_speed: input.y = max_speed
	if input.y < -max_speed: input.y = -max_speed	

func go_left(delta): input.x -= acceleration * delta

func go_right(delta): input.x += acceleration * delta

func go_up(delta): input.y -= acceleration * delta
	
func go_down(delta): input.y += acceleration * delta
		
func deaccelerate_horizontal(delta):
	if input.x < 0: input.x += deacceleration * delta
	if input.x > 0: input.x -= deacceleration * delta	
	
func deaccelerate_vertical(delta):
	if input.y < 0: input.y += deacceleration * delta
	if input.y > 0: input.y -= deacceleration * delta

func check_shoot():
	if Input.is_action_just_pressed("shoot") and visible:		
		emit_signal("spawn_laser", Laser, muzzle.global_position)

func _on_Area2D_area_entered(area):
	if area.type == 'enemy':
		area.enemy_dies()
		player_die()	
	
func player_die():
	$Sprite.visible = false
	is_dead = true
	$Explosion.start()	
	$TimerToDie.start()
	
func _on_TimerToDie_timeout():	
	hide_player()
	lose_life()
	
func reset_position(): position = intitial_position
	
func reset_speed():
	input.x = 0
	input.y = 0
	
func lose_life():
	lives -= 1
	if lives > 0: $TimerToRespawn.start()
	else: get_parent().game_over()
	
func _on_TimerToRespawn_timeout():
	reset_position()
	reset_speed()
	show_player()
	
func hide_player():
	visible = false
	call_deferred('_disable_collision_shape')
	
func _disable_collision_shape():
	$CollisionShape2D.disabled = true
	$Area2D/CollisionShape2D.disabled = true
	
func show_player(): 
	is_dead = false
	$Sprite.visible = true
	visible = true	
	is_blinking = true
	$TimerInvencible.start()
	
func add_points(points_added): 
	points += points_added
	get_parent().get_node("Hud").update_score(points)

func _on_TimerInvencible_timeout():
	is_blinking = false
	$CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D.disabled = false
	
func get_lives(): return lives

func get_points(): return points
	
func add_life(): 
	if lives < max_lives:		
		lives += 1
		get_parent().get_node("Hud").show_extra_life()
