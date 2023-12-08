extends Node2D

enum forms {LINE, L, J, T, CUBE, Z, ZZ}

var colors = ["008aff", "ffff00", "ff00ff", "002fff", "e89600", "c77fff", "16c000"]

var size = 40
@export var type = forms.L
var rotation_count = 0

#edges in global coordinates
#x is left edge and y is right
var bound: Vector2
var down: float

signal stopped

#making a form we specified and coloring all blocks
func _ready():
	match  type:
		forms.LINE:
			get_child(0).position = Vector2(2*size,-size)
		forms.CUBE:
			get_child(1).position = Vector2(0,0)
		forms.J:
			get_child(0).position = Vector2(size,0)
		forms.T:
			get_child(0).position = Vector2(0,0)
		forms.Z:
			get_child(1).position = Vector2(0,-2*size)
		forms.ZZ:
			get_child(1).position = Vector2(-2*size, 0)
	
	for child in get_children():
		child.modulate = Color(colors[type])
		
	bound.x = get_parent().get_global_position().x
	bound.y = bound.x + get_parent().get_size().x
	down = get_parent().get_global_position().y
	down += get_parent().get_size().y

func _input(event):
	if event.is_action_pressed("rotate"):
		rotate_piece()
	if event.is_action_pressed("left"):
		if is_there_left():
			print("position.x = ", position.x)
			print("position global x = ", get_global_position().x)
			print("position ch[0] x = ", get_child(1).position.x)
			print("ch0 global x = ", get_child(1).get_global_position().x)
			print()
			position.x -= size
	if event.is_action_pressed("right"):
		if is_there_right():
			position.x += size
	if event.is_action_pressed("down"):
		move()
		

func rotate_piece():
	rotation += PI/2
	return
	match  type:
		forms.CUBE:
			return
		forms.Z:
			var shift = size
			if rotation_count > 0:
				shift = -shift
			rotation_count = (rotation_count + 1) % 2
			get_child(0).position.x += shift
			get_child(1).position.x += shift
			get_child(1).position.y += 2*shift
		forms.ZZ:
			var shift = size
			if rotation_count == 0:
				rotation_count = 1
			else:
				rotation_count = 0
				shift = -shift
		forms.LINE:
			pass
		forms.J:
			pass
		forms.T:
			pass

		

func move():
	if is_there_down():
		position.y += size
	else:
		get_tree().get_current_scene().find_child("Timer").stop()
		stopped.emit()

func is_there_left():
	for block in get_children():
		var pos = block.get_global_position()
		if pos.x <= bound.x:
			return false
		for child in get_parent().find_child("static").get_children():
			var pos2 = child.get_global_position() 
			if pos2.y == pos.y and pos2.x + size == pos.x:
				return false
	return true

func is_there_right():
	for block in get_children():
		var pos = block.get_global_position()
		if pos.x >= bound.y - size:
			return false
		for child in get_parent().find_child("static").get_children():
			var pos2 = child.get_global_position() 
			if pos2.y == pos.y and pos2.x == pos.x + size:
				return false
	return true

func is_there_down():
	for block in get_children():
		var pos = block.get_global_position()
		if pos.y + size >= down:
			return false
		for child in get_parent().find_child("static").get_children():
			var pos2 = child.get_global_position() 
			if pos2.x == pos.x and pos2.y == pos.y + size:
				return false
	return true










