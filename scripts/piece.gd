class_name Piece
extends Node2D

signal stopped
enum forms {CUBE, LINE, L, Z, S, J, T}

static var scripts = [
	preload("res://scripts/cube.gd"), 
	preload("res://scripts/line.gd"),
	preload("res://scripts/L.gd"),
	preload("res://scripts/Z.gd"),
	preload("res://scripts/S.gd"),
	preload("res://scripts/J.gd"),
	preload("res://scripts/T.gd")
]

var block_texture = preload("res://block.png")

var type: int
var color: String
static var size = 40

#variables to control movement
#if the player presses a key for a long, we should move the piece continuously
#(with an initial delay though)
var wait = 0.08
var delay = -0.4
var elapsed = delay

#edges in global coordinates
#x is left edge and y is right
var bound: Vector2
var down

static func create(type):
	return scripts[type].new()

func _init():
	for i in range(4):
		var node = Sprite2D.new()
		node.set_texture(block_texture)
		node.modulate = Color(color)
		add_child(node)

func _ready():
	bound.x = get_parent().get_global_position().x
	bound.y = bound.x + get_parent().get_size().x
	down = get_parent().get_global_position().y
	down += get_parent().get_size().y

func _input(event):
	if event.is_action_pressed("left"):
		if is_there_left():
			position.x -= size
			elapsed = delay
	if event.is_action_pressed("right"):
		if is_there_right():
			position.x += size
			elapsed = delay
	if event.is_action_pressed("down"):
		move()
		elapsed = delay
	if event.is_action_pressed("rotate"):
		rotate_piece()
	if event.is_action_pressed("fast_down"):
		while(is_there_down()):
			move()

func _process(delta):
	elapsed += delta
	if elapsed < wait:
		return
	elapsed = 0
	if Input.is_action_pressed("left"):
		if is_there_left():
			position.x -= size
	if Input.is_action_pressed("right"):
		if is_there_right():
			position.x += size
	if Input.is_action_pressed("down"):
		move()

#reset rotation after every round so roundoff is not accumulated
func rotate_piece():
	rotation += PI/2
	if is_equal_approx(rotation , 2*PI):
		rotation = 0

func move():
	if is_there_down():
		position.y += size
	else:
		get_tree().get_current_scene().find_child("Timer").stop()
		stopped.emit()

func is_there_left():
	for block in get_children():
		var pos = block.get_global_position()
		if pos.x <= bound.x + size/2:
			return false
		for child in get_parent().find_child("static").get_children():
			var pos2 = child.get_global_position() 
			if pos2.y == pos.y and pos2.x + size == pos.x:
				return false
	return true

func is_there_right():
	for block in get_children():
		var pos = block.get_global_position()
		if pos.x >= bound.y - size/2:
			return false
		for child in get_parent().find_child("static").get_children():
			var pos2 = child.get_global_position() 
			if pos2.y == pos.y and pos2.x == pos.x + size:
				return false
	return true

func is_there_down():
	for block in get_children():
		var pos = block.get_global_position()
		if pos.y + size > down:
			return false
		for child in get_parent().find_child("static").get_children():
			var pos2 = child.get_global_position()
			if pos2.x == pos.x and pos2.y == pos.y + size:
					return false
	return true










