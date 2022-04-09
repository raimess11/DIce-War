extends Node2D

onready var Map = $Map
onready var TeritoryMap = $TeritoryMap

var post = Vector2.ZERO
var teritory_area
export var color:int

func _ready():
	generate_map()

func generate_map():
	for area in teritory_area:
		Map.set_cellv(area, 0)
	for area in teritory_area:
		TeritoryMap.set_cellv(area, color if color != null else 0)
	#TeritoryMap.set_cellv(post, 7)


func input(event):
	if event is InputEventMouseButton:
		var mousePosition = get_node("/root/World/Teritory/Map").world_to_map(get_global_mouse_position()*5)
		if Map.get_used_cells().has(mousePosition):
			print(color)
