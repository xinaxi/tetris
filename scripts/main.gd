extends Node

var piece_class = preload("res://scripts/piece.gd")
var size = Piece.size
var current = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("start"):
		InputMap.erase_action("start")
		make_new()
		


func make_static():
	for child in current.get_children():
		var pos = child.get_global_position()
		current.remove_child(child)
		$viewport/static.add_child(child)
		child.set_global_position(pos)
	current.queue_free()
	make_new()


func make_new():
	current = piece_class.create(randi_range(0,6))
	current.position = Vector2(9*size/2,size/2)
	$viewport.add_child(current)
	var node = $PointLight2D.duplicate()
	current.add_child(node)
	node.set_global_position(current.get_global_position())
	
	$Timer.timeout.connect(current.move)
	$Timer.start()
	current.stopped.connect(make_static)



