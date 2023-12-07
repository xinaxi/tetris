extends Node2D

enum forms {
	LINE,
	L,
	J,
	T,
	CUBE,
	Z,
	ZZ
}

var colors = ["008aff", "ffff00", "ff00ff", "002fff", "e89600", "c77fff", "16c000"]

var size = 40
@export var type = forms.L

func _ready():
	match  type:
		forms.LINE:
			get_child(0).position = Vector2(2*size,0)
		forms.CUBE:
			get_child(1).position = Vector2(0,size)
		forms.J:
			get_child(0).position = Vector2(size,size)
		forms.T:
			get_child(0).position = Vector2(0,size)
		forms.Z:
			get_child(1).position = Vector2(0,-size)
		forms.ZZ:
			get_child(1).position = Vector2(-2*size,0)
	
	for child in get_children():
		child.modulate = Color(colors[type])


func _input(event):
	if event.is_action_pressed("rotate"):
		if type != forms.CUBE:
			rotation += PI/2
	if event.is_action_pressed("left"):
		position.x -= size
	if event.is_action_pressed("right"):
		position.x += size
	if event.is_action_pressed("down"):
		position.y += size
		

func on_timer_timeout():
	position.y += size


