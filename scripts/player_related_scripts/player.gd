extends CharacterBody2D

@export var mining_tool : Node

@export_group("Experimental")
@export var gravity_experiment : bool = false
@export_subgroup("jumping")
@export var jump_height : int
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) *-1
@onready var jump_gravity = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) *-1
@onready var fall_gravity = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) *-1

## Handel movement input
enum Movement {DEFAULT = 0, LEFT = -1, RIGHT = 1, UP = 2, DOWN = 3}
var current_movement : int


func _physics_process(delta):
	receive_movement_input()
	if not gravity_experiment:
		#handle_movement(current_movement)
		new_movement()
	move_and_slide()
	### Experimental - Turn ON/OFF via editor
	if gravity_experiment:
		exp_apply_gravity(delta)
		exp_handle_movement(current_movement, delta)

func new_movement():
	var input_vector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		).normalized()
	velocity = input_vector * 150
	
func receive_movement_input():
	if Input.is_action_pressed("left"):
		current_movement = Movement.LEFT
	elif Input.is_action_pressed("right"):
		current_movement = Movement.RIGHT
	elif Input.is_action_pressed("up"):
		current_movement = Movement.UP
	elif Input.is_action_pressed("down"):
		current_movement = Movement.DOWN
	else:
		current_movement = Movement.DEFAULT

func handle_movement(movement : int):
	var move_direction : Vector2
	match movement:
		Movement.LEFT:
			move_direction = Vector2(-1, 0)
		Movement.RIGHT:
			move_direction = Vector2(1, 0)
		Movement.UP:
			move_direction = Vector2(0, -1)
		Movement.DOWN:
			move_direction = Vector2(0, 1)
		Movement.DEFAULT:
			move_direction = Vector2(0, 0)
	## Move in direction
	velocity = move_direction * 150


### Funktion Experimental
func exp_apply_gravity(delta):
	if velocity.y < 0.0:
		velocity.y += jump_gravity * delta
	else:
		velocity.y += fall_gravity * delta

func exp_handle_movement(movement : int, delta):
	var move_direction : Vector2
	match movement:
		Movement.LEFT, Movement.RIGHT, Movement.DEFAULT:
			velocity.x = move_toward(velocity.x, 100 * movement, 1500 * delta)
		Movement.UP:
			if is_on_floor():
				velocity.y = jump_velocity
