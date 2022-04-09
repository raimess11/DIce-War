extends Node
class_name Walker

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
var claimed_teritory = []
var teritorys = []
var temporary_teritory = []

var MAKE_TERITORY

func _init(starting_possition, new_border):
	assert(new_border.has_point(starting_possition))
	position = starting_possition
	step_history.append(position)
	border = new_border

func walk(steps):
	create_teritory(position)
	for step in steps:
		if randf() < (0.4 * step_since_return) and not claimed_teritory.has(position):
			for i in temporary_teritory:
				teritorys.append(i)
				claimed_teritory.append(i)
			change_direction()
			temporary_teritory.clear()
		if step():
			pass
		else:
			change_direction()
	return [step_history, teritory]

func step():
	var target_postion = position + direction
	if border.has_point(target_postion):
		position = target_postion
		if not claimed_teritory.has(target_postion):
			step_since_return += 1
			temporary_teritory.append(position)
			for a in DIRECTION:
				if not claimed_teritory.has(position + a):
					temporary_teritory.append(position + a)
		else:
			step_since_return = 0
			temporary_teritory.clear()
		return true
	else:
		return false

func change_direction():
	step_since_return = 0
	var directions = DIRECTION.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not border.has_point(position + direction):
		direction = directions.pop_front()
	create_teritory(position)

func create_teritory(current_position):
	var directions = DIRECTION.duplicate()
	var color = round(rand_range(1,6))
	
	var black_list = [DIRECTION[round(rand_range(0,DIRECTION.size() - 1))],DIRECTION[round(rand_range(0,DIRECTION.size() - 1))]]
	black_list.resize(round(rand_range(0,2)))
	var skip_tile = []
	var limit = 0
	var black_size = black_list.size()
	for x in black_list:
		directions.erase(x)
	teritorys.append(current_position)
	for f in directions:
		if not teritorys.has(current_position + f) and not skip_tile.has(current_position + f ) and not claimed_teritory.has(current_position + f):
			teritorys.append(current_position + f)
		else:
			black_size += 1
	for a in directions:
		for b in directions:
			if not teritorys.has(current_position + a + b) and not skip_tile.has(current_position + a + b ) and not claimed_teritory.has(current_position + a + b):
				if randf() < 0.8 or limit > (round(4 / (black_list.size()+1))) :
					teritorys.append(current_position + a + b)
				else:
					skip_tile.append(current_position + a + b)
					limit += 1
			else:
				pass
	for area in teritorys:
		claimed_teritory.append(area)
	teritory.append([current_position,teritorys,color])
	teritorys = []

