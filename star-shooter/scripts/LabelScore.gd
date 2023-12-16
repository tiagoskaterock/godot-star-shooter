extends Label

func _process(delta):
	var player_points = get_parent().get_parent().get_parent().get_node('Player').get_points()
	text = 'SCORE: ' + str(player_points)
