extends CharacterBody2D


@export var mov_comp = Node
### NEEDS:
#	health_component : Node
# damage_component : Node
# enemie_hitbox_component : Node
# damage component
func _physics_process(delta):
	velocity = mov_comp.pass_velocity()
	move_and_slide()
