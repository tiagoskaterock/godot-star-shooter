extends Control

var showing_extra_life = false

func _ready():
	update_ammo(get_parent().get_node("Player").get_ammo())
	
func _process(delta):
	if(showing_extra_life): blink_extra_life()
	else: $LabelExtraLife.visible = false
	
func update_score(new_score):
	$ScoreLabel.text = "SCORE: " + str(new_score)
	
func update_ammo(new_ammo):
	$AmmoLabel.text = "AMMO: " + str(new_ammo)
	
func update_difficulty(new_difficulty):
	$ScoreDifficulty.text = "DIFFICULTY: " + str(new_difficulty)
	
func show_extra_life():
	$AudioExtraLife.play()
	showing_extra_life = true
	$TimerToStopExtraLife.start()
	
func blink_extra_life(): $LabelExtraLife.visible = ! $LabelExtraLife.visible
	
func _on_TimerToStopExtraLife_timeout():
	print('timer stops')
	showing_extra_life = false
