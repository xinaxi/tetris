extends Node

var piece_class = preload("res://scripts/piece.gd")
var size = Piece.size
var current = null

var rows = []

func _ready():
	rows.resize(20)
	rows.fill(0)
	make_new()

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func make_static():
	for child in current.get_children():
		child.reparent($viewport/static)
		rows[child.get_global_position().y / size - 1 as int] += 1
	current.queue_free()
	check()
	make_new()

func make_new():
	current = piece_class.create(randi_range(0,6))
	current.position = Vector2(9*size/2,size/2)
	$viewport.add_child(current)
	$Timer.timeout.connect(current.move)
	$Timer.start()
	current.stopped.connect(make_static)

func check():
	for i in rows.size():
		if rows[i] == 10:
			delete_row(i)

func delete_row(num):
	var y = num*size + size/2
	for child in $viewport/static.get_children():
		if child.position.y < y:
			child.position.y += size
		elif child.position.y == y:
			child.queue_free()
	for i in range(num,0,-1):
		rows[i] = rows[i-1]





