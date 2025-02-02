extends Node2D
 
class_name enemie_hitbox_component

@export var health_cmp : health_component
@export var dmg_cmp_enemies : damage_component_enemies

@export var repeat_time = 0.25

func _ready():
	$RepeatedAreaEnteredSignal.wait_time = repeat_time

func receive_damage(damage : float):
	health_cmp.receive_damage(damage)


func _on_area_2d_body_entered(body):
	print("body entered area enemie hitbox")
	if body.name == "Player":
		$RepeatedAreaEnteredSignal.start()
		#print("body is player")
		dmg_cmp_enemies.apply_damage()


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		#print("player_Exit")
		$RepeatedAreaEnteredSignal.stop()


func _on_repeated_area_entered_signal_timeout():
	dmg_cmp_enemies.apply_damage()
	print("stayed in area")
