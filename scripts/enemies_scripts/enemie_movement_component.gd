extends Node2D


@export var speed : int

@onready var nav = $NavigationAgent2D

var velocity = Vector2(0,0)

var go = false

func _ready():
	$Timer.start()
	#call_deferred(setup_my())
	#nav.target_position = Vector2(131, -16)
	set_physics_process(false)
	await get_tree().physics_frame
	set_physics_process(true)
	print("ready")


func _physics_process(delta):
	if go:
		nav.target_position = get_parent().get_parent().get_node("Player").global_position
		
		var current_agent_position = global_position
		var next_path_position = nav.get_next_path_position()# -global_position

		velocity = current_agent_position.direction_to(next_path_position) * speed
		
### not selfcall
func pass_velocity():
	return velocity


func _on_timer_timeout():
	go = true
