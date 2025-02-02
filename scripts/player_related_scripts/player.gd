extends CharacterBody2D
class_name PlayerChar

### Player Class
### Handles Movement and nothing else -> Logick relating Mining,
### Fighting is handled within the MiningTool Module

@export var mining_tool : Node
## Handel movement input
enum Movement {DEFAULT = 0, LEFT = -1, RIGHT = 1, UP = 2, DOWN = 3}
var current_movement : int


func _physics_process(delta):
	receive_movement_input()
	new_movement()
	move_and_slide()


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
