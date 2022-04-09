extends Node
class_name Topografer

const N = Vector2(0,2)
const S = Vector2(0,-2)
const NE = Vector2(1,-1)
const SE = Vector2(1,1)
const SW = Vector2(-1,1)
const NW = Vector2(-1,-1)

const DIRECTION = [N ,S ,NE ,SE ,SW ,NW ]


var direction = NE
var position = Vector2.ZERO
var border = Rect2()
var step_history = []
var step_since_return = 0

var teritory = []

func _init(starting_possition, new_border):
	assert(new_border.has_point(starting_possition))
	position = starting_possition
	step_history.append(position)
	border = new_border

func walk(steps):
	create_teritory(position)
	for step in steps:
		if (step_since_return >= 3 and randf() < 0.5) or step_since_return >= 5:
			change_direction()
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

func step():
	var target_postion = position + direction
	if border.has_point(target_postion):
		step_since_return += 1
		position = target_postion
		return true
	else:
		return false

func change_direction():
	create_teritory(position)
	step_since_return = 0
	var directions = DIRECTION.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not border.has_point(position + direction):
		direction = directions.pop_front()
	

func create_teritory(new_position):
	var color = round(rand_range(1,5))
	teritory.append([new_position, color])
	var directions = DIRECTION.duplicate()
	var teritorys = []
	directions.shuffle()
	#directions.resize(directions.size() - 1)
	for a in directions:
		for b in directions:
			teritorys.append(new_position + a + b)
	for area in teritorys:
		teritory.append([area,color])
	var a = 0















