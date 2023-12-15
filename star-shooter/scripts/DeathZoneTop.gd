extends Area2D

const type = 'death_zone_top'

func _on_DeathZoneTop_area_entered(area):	
	area.queue_free()

func _on_DeathZoneTop_body_entered(body):
	body.queue_free()
