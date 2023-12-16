extends Node2D

func _ready(): random_x()
	
func random_x(): return randi() % (491 - 50) + 50
