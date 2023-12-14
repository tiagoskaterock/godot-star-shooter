extends KinematicBody2D

export (int) var max_speed = 500
var acceleration = 2000
var deacceleration = acceleration / 2
var input = Vector2.ZERO
var min_speed_to_move = 15
var intitial_position = Vector2(256, 872)
var lives = 5
var poinst = 0
var type = 'player'

func _physics_process(delta):
	check_min_speed()
	check_move(delta)
	check_shoot()
	limit_on_screen()
	move_and_slide(input)
	
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
	if Input.is_action_just_pressed("shoot"):
		print('shoot')

func _on_Area2D_area_entered(area):
	if area.type == 'enemy':
		area.enemy_hit()
		player_die()	
	
func player_die():
	$Explosion.play()
	lose_life()	
	
func reset_position():
	position = intitial_position
	
func reset_speed():
	input.x = 0
	input.y = 0
	
func lose_life():
	lives -= 1	
	hide_player()
	$TimerToRespawn.start()
	print("Player Lives: " + str(lives))

func _on_TimerToRespawn_timeout():
	reset_position()
	reset_speed()
	show_player()
	
func hide_player():
	visible = false  # Oculta o KinematicBody2D inteiro
	
func show_player():
	visible = true
