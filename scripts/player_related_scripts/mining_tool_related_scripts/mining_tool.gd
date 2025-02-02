extends Node2D

@export var damage_component : Node
@export var _beam_component : Node

func _ready():
	if damage_component == null:
		print("ERROR: No damage_component assigned")
	if _beam_component == null:
		print("ERROR: No beam_component assigned")

func _process(delta):
	set_target_position()

func set_target_position() -> void:
	look_at(get_global_mouse_position())
