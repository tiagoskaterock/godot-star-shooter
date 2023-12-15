extends Node2D

const NORMALENEMY = preload("res://star-shooter/scenes/NormalEnemy.tscn")
const DIVERENEMY = preload("res://star-shooter/scenes/DiverEnemy.tscn")
const SHOOTTINGENEMY = preload("res://star-shooter/scenes/ShoottingEnemy.tscn")

func _ready(): $BGMusic.play()	

func _physics_process(delta): pass

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

func _on_TimerToSpawnEnemy_timeout():
	var x_position = $EnemySpawner.random_x()
	choose_random_enemy(x_position)
	
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
