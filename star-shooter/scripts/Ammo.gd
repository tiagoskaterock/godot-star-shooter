extends Area2D

class_name Ammo

export var how_much_to_recharge : int = 40
export var speed : int = 100


func _process(delta):
	position.y += speed * delta
	

func _on_Ammo_body_entered(body):
	if body is Player:
		body.add_ammo(how_much_to_recharge)
		success()


func _on_Ammo_area_entered(area):
	area.queue_free()
	explode()


func explode():
	print('explode')
	queue_free()
	
	
func success():
	$Sprite.hide()
	$RechargeSFX.play()
	yield($RechargeSFX, "finished")
	queue_free()
