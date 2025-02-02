extends RigidBody2D

func _ready():
	get_node("Collision").scale = Vector2(0.2, 0.2)
	
	## graphic is attached top left corner
	
	get_node("Graphic").scale = Vector2(0.2, 0.2)
	var size = get_node("Graphic").size
	get_node("Graphic").position = Vector2(0,0)  - get_node("Graphic").size *0.2 *0.5
	pass


func _on_body_entered(body):
	if body.name == "Player":
		AutoloadMinerals.minerals_bg = 1
		queue_free()
