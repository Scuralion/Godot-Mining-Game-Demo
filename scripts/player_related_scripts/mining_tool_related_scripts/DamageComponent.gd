extends Node2D

class_name damage_component

signal tool_hits_block
var damage_tic_cooldown = false

@export var tool_damage : int
@export var damage_tic_time : float

func _ready():
	$DamageDelayTimer.wait_time = damage_tic_time


func apply_damage(target_rid : RID, target_obj : Object) -> void:
	### handle damage dealing to block / enemies
	if !damage_tic_cooldown:
		print(target_obj)
		### IF hit object is TileMap:
		if (target_obj is TileMap):
			tool_hits_block.emit(target_rid)
		else:### Enemies hit
			target_obj.get_parent().receive_damage(tool_damage)
		$DamageDelayTimer.start()
		damage_tic_cooldown = true


func _on_damage_delay_timer_timeout():
	damage_tic_cooldown = false
