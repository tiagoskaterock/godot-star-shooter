extends Control

func update_score(new_score):
	$ScoreLabel.text = "SCORE: " + str(new_score)
	
func update_difficulty(new_difficulty):
	$ScoreDifficulty.text = "DIFFICULTY: " + str(new_difficulty)
