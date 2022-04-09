extends Node2D

var borders = Rect2(3,3,35,63)

const TERITORY = preload("res://Teritory.tscn")

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(round(rand_range(3, 35)), round(rand_range(3,63))), borders)
	var teritory_data = walker.walk(100)
	for area in teritory_data[1]:
		var teritory = TERITORY.instance()
		teritory.post = area[0]
		teritory.teritory_area = area[1]
		teritory.color = area[2]
		add_child(teritory)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("ui_right"):
		var mousePosition = get_node("/root/World/Teritory/Map").world_to_map(get_global_mouse_position()*5)
		print(mousePosition)
	
