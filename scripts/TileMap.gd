extends TileMap

class_name custom_tilemap

### ATTENTION: The correct Autotiling makes use of "Better Terrain" by "Portponky"
### As of the Date of Publishin this, Beter Terrain is NOT! Compatible with the new TilemapLayer Node
### that superceded Tilemaps as of Godot 4.3
### If you want to refactor this into TilemapLayers, be aware this requires a rework of the Autotiling System


var layer_minerals = 1
var layer_breaking_points = 2
var layer_shading = 3
var mining_id = 1
var shading_id = 2
var mineras_and_breaking_id = 4

@onready var cell_store_array : Array
@onready var cell_health_array : Array
@onready var cell_health = 40
@export var nav_reg : Node

signal block_removed

func _ready():
	if nav_reg == null:
		print("No Navigation Region Connected")
	## create an array holding all minable blocks with healtbars
	add_shading_to_cells()
	cell_store_array = get_used_cells_by_id(0,1)
	cell_store_array.sort()
	## create array with health of every minable block - More complicated once different blocks arise
	for i in cell_store_array.size():
		cell_health_array.append(cell_health)


func damage_received(hit_block : RID):
	var tilemap_cord_hit = get_coords_for_body_rid(hit_block)
	var cell_tile_data_hit = get_cell_tile_data(0, tilemap_cord_hit)
	var minable = cell_tile_data_hit.get_custom_data("Minable")
	var cell_max_health = cell_tile_data_hit.get_custom_data("block_max_health")
	### Only Minable Blocks take damge
	if minable:
		var index = cell_store_array.bsearch(tilemap_cord_hit)
		cell_health_array[index] -= get_parent().player.mining_tool.damage_component.tool_damage
		add_block_breaking_marks(cell_max_health, cell_health_array[index], tilemap_cord_hit)
		### If the Block gets destroyed, remove it, spawn crystals and force update tilemap
		if cell_health_array[index] <= 0:
			remove_minerals(tilemap_cord_hit)
			set_cell(0,cell_store_array[index])
			BetterTerrain.update_terrain_cells(self, 0, cell_store_array) ### BETTER TERRAIN DEPENDANCY
			add_shading_to_cells()
			block_removed.emit()


func add_block_breaking_marks(max_block_health : int, current_block_health : int, block_position : Vector2i) ->void:
	var breaking_tile : Vector2i
	if current_block_health >= max_block_health * 0.01 * 70:
		breaking_tile = Vector2i(0,1)
	elif current_block_health >= max_block_health * 0.01 * 40:
		breaking_tile = Vector2i(1,1)
	elif current_block_health > 0:
		breaking_tile = Vector2i(2,1)
	elif current_block_health <= 0:
		breaking_tile = Vector2i(-1,-1)
	set_cell(layer_breaking_points, block_position, mineras_and_breaking_id, breaking_tile)


func remove_minerals(coordinates : Vector2i) -> void:
	if get_cell_atlas_coords(layer_minerals, coordinates) != Vector2i(-1,-1):
		set_cell(layer_minerals, coordinates)
		spawn_crystals(coordinates)


func spawn_crystals(spawnposition : Vector2i) -> void:
	for i in 3:
		var crystal = preload("res://scenes/level_related/crystal_body.tscn")
		crystal = crystal.instantiate()
		crystal.position = map_to_local(spawnposition)
		get_parent().add_child(crystal)


func add_shading_to_cells():
	clear_layer(layer_shading)
	var mining_cells = get_used_cells_by_id(0,mining_id)
	for i in mining_cells.size():
		set_cell(layer_shading, mining_cells[i], shading_id, get_cell_atlas_coords(0, mining_cells[i]))
