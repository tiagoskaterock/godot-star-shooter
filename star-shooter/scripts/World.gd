extends Node2D

const NORMALENEMY = preload("res://star-shooter/scenes/NormalEnemy.tscn")
const DIVERENEMY = preload("res://star-shooter/scenes/DiverEnemy.tscn")
const SHOOTTINGENEMY = preload("res://star-shooter/scenes/ShoottingEnemy.tscn")
var difficulty = 1
var difficulty_was_increased = false
var divisor_to_increse_difficulty = 500
var multiplier_to_increase_difficulty = 1
var difficulty_levels_to_get_new_life = 3

func _ready(): 
	$Hud.update_difficulty(difficulty)	

func _process(delta):
	check_difficulty()

func _on_Player_spawn_laser(Laser, location):
	var laser = Laser.instance()
	add_child(laser)
	laser.play_laser_fx_01()
	laser.global_position = location

func _onEnemySpawnLaser(Laser, location):
	location.y += 30
	var laser = Laser.instance()
	add_child(laser)
	laser.play_laser_fx_01()
	laser.global_position = location
	
func spawn_normal_enemy(x_position):
	var new_enemy = NORMALENEMY.instance()
	new_enemy.position.x = x_position
	add_child(new_enemy)
	
func spawn_diver_enemy(x_position):
	var new_enemy = DIVERENEMY.instance()
	new_enemy.position.x = x_position
	add_child(new_enemy)
	
func spawn_shooting_enemy(x_position):	
	var new_enemy = SHOOTTINGENEMY.instance()
	new_enemy.connect("enemy_spawn_laser", self, "_onEnemySpawnLaser")
	new_enemy.position.x = x_position
	new_enemy.can_shoot = true
	add_child(new_enemy)
	
func choose_random_enemy(x_position):
	var numero_aleatorio = randi() % 3 + 1
	if numero_aleatorio == 1: spawn_normal_enemy(x_position)
	elif numero_aleatorio == 2: spawn_diver_enemy(x_position)
	elif numero_aleatorio == 3: spawn_shooting_enemy(x_position)
	
func game_over(): 
	$CanvasLayerGameOver/GameOverMenu.visible = true
	$BGMusic.stop()
	$TimerToSpawnEnemy.stop()
	
func check_difficulty():
	var points = $Player.get_points()
	if ! difficulty_was_increased:
		if points >= divisor_to_increse_difficulty * multiplier_to_increase_difficulty:
			difficulty_was_increased = true
			multiplier_to_increase_difficulty += 1
			difficulty_was_increased = false
			increase_difficulty()
			
func increase_difficulty():
	difficulty += 1
	$Hud.update_difficulty(difficulty)
	check_if_add_life()
	
func get_difficulty():
	return difficulty
	
func check_if_add_life():
	if difficulty % difficulty_levels_to_get_new_life == 0: $Player.add_life()
