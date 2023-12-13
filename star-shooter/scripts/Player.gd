extends KinematicBody2D

export (int) var max_speed = 500
var acceleration = 900
var deacceleration = 500
var input = Vector2.ZERO

func _physics_process(delta):
	check_move(delta)
	check_shoot()
	global_position.x = clamp(global_position.x, 50, 490)
	global_position.y = clamp(global_position.y, 40, 920)
	move_and_slide(input)
	
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
