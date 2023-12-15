extends Control

func update_score(new_score):
	$ScoreLabel.text = "SCORE: " + str(new_score)
	
func update_lives(new_lives):
	$LivesLabel.text = "LIVES: " + str(new_lives)
	
