extends Node2D

func _process(delta):	
	update_hud_lives()
	
func update_hud_lives():
	var lives = get_parent().get_parent().get_node("Player").get_lives()
	
	if lives <= 4: $Sprite5.visible = false
	else: $Sprite5.visible = true
	
	if lives <= 3: $Sprite4.visible = false	
	else: $Sprite4.visible = true
	
	if lives <= 2: $Sprite3.visible = false
	else: $Sprite3.visible = true
	
	if lives <= 1: $Sprite2.visible = false
	else: $Sprite2.visible = true
	
	if lives <= 0: $Sprite1.visible = false
	else: $Sprite1.visible = true
	
