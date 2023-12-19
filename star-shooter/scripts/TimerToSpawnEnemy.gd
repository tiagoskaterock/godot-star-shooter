extends Timer

func _on_TimerToSpawnEnemy_timeout():
	var difficulty = get_parent().get_difficulty()
	print(difficulty)
	
	if difficulty < 3: wait_time = 1
	elif difficulty < 6: wait_time = .75
	elif difficulty < 10: wait_time = .5
	else: wait_time = .4
	
	var x_position = get_parent().get_node("EnemySpawner").random_x()
	get_parent().choose_random_enemy(x_position)
	
