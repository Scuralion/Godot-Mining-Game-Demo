extends Node2D

class_name Level

### Base Level
### Used to connect Signals from and To the Player

var node

@export var player : CharacterBody2D

func _ready():
### TEMPORARY FIX!
### In game, player swtiches between weapons, so upon weapon switch the conection must be made via player script
	var damagecomponent = get_node("Player/MiningTool/DamageComponent")
	var tilemap = get_node("TileMap")
	damagecomponent.tool_hits_block.connect(tilemap.damage_received)
