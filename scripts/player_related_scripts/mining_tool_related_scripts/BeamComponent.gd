extends Node2D

@export var tool_length : int
@export var color_beam : Color

@export var damage_component : Node

@onready var particles_origin = $ParticlesOrigin
@onready var particles_impact = $ParticlesImpact
@onready var particles_beam_length = $ParticlesBeamLength
@onready var shapecast = $ShapeCast2D
@onready var particles_end = $ParticlesEnd

var is_casting : bool = false:
	set(value):
		is_casting = value
		particles_origin.emitting = is_casting
		particles_beam_length.emitting = is_casting
		shapecast.enabled = is_casting
		if is_casting:
			appear()
		else:
			disappear()
			particles_end.emitting = false
		set_process(is_casting)

func _ready():
	$ShapeCast2D/Line2D.modulate = color_beam
	particles_beam_length.modulate = color_beam
	particles_origin.modulate = color_beam
	particles_end.modulate = color_beam
	is_casting = false
	shapecast.target_position = Vector2(tool_length,0)

func _physics_process(delta):
	beam()

## Casts beam on click
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		self.is_casting = event.pressed

### Casts the beam and handles collision
func beam():
	var impact_point = shapecast.target_position
	
	if shapecast.is_colliding():
		
		damage_component.apply_damage(shapecast.get_collider_rid(0), shapecast.get_collider(0))
		impact_point = to_local(shapecast.get_collision_point(0))
		particles_impact.global_rotation = shapecast.get_collision_normal(0).angle()
		particles_impact.position = impact_point
		particles_impact.emitting = true
		#$ShapeCast2D/Line2D.points[1] = impact_point
		particles_end.position = impact_point
	else:
		particles_impact.emitting = false
		if is_casting:
			particles_end.emitting = true
			particles_end.position = impact_point
	$ShapeCast2D/Line2D.points[1] = impact_point
	particles_beam_length.position = impact_point * 0.5
	particles_beam_length.process_material.emission_box_extents.x = impact_point.length() * 0.5
	
### Makes Beam Visible
func appear():
	var tween = create_tween()
	tween.tween_property($ShapeCast2D/Line2D, "width", 3.0, 0.1)
### Makes Beam Invisible
func disappear():
	var tween = create_tween()
	tween.tween_property($ShapeCast2D/Line2D, "width", 0, 0.1)
