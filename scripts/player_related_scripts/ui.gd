extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	### Conect signals
	AutoloadMinerals.minerals_bg_updated.connect(update_label_bg)
	
	### Set UI To Top-Left Corner
	var zoom = 1/get_parent().get_node("Camera2D").zoom.x
	position = get_viewport_rect().size * -0.5 * (zoom)
	## scale reltativ zo zoom
	scale = Vector2(zoom,zoom)
	
	##Rescale stuff
	await get_tree().process_frame
	get_node("MarginContainer/VBoxContainer").scale = Vector2(2,2)
	

func update_label_bg() -> void:
	$MarginContainer/VBoxContainer/HBoxContainer/LabelMineralsBG.text = str(AutoloadMinerals.minerals_bg)
