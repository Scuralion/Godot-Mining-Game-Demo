extends Node2D

class_name health_component

@export var health : int

@onready var current_health = health


func receive_damage(damage : float):
	current_health -= damage
	if current_health <= 0:
		print("HC: Death")
		death()
	print(current_health)

func death() -> void:
	get_parent().queue_free()
