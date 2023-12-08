extends Node

var piece_scene = preload("res://scenes/piece.tscn")
var size = 40
var current = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("start"):
#		make_new()
		for i in range(7):
			current = piece_scene.instantiate()
			current.type = i
			current.rotation += PI/2
			if i%2 == 0:
				current.position = Vector2(4*size,4*size*i/2)
			else:
				current.position = Vector2(8*size,4*size*i/2)
			$viewport.add_child(current)
			var pl = $PointLight2D.duplicate()
			$viewport.add_child(pl)
			pl.set_global_position(current.get_child(0).get_global_position())
			


func make_static():
	for child in current.get_children():
		var pos = child.get_global_position()
		current.remove_child(child)
		$viewport/static.add_child(child)
		child.set_global_position(pos)
	current.queue_free()
	make_new()
		
func make_new():
	current = piece_scene.instantiate()
#	current.type = randi_range(0,6)
	current.position = Vector2(4*size,0)
	$viewport.add_child(current)
	$Timer.timeout.connect(current.move)
	$Timer.start()
	current.stopped.connect(make_static)



