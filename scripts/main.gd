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
		make_new()

func move():
	current.position.y += size
	if no_place():
		$Timer.stop()
		make_static()

func no_place():
	if current.position.y > 200:
		return true
	else:
		return false

func make_static():
	for child in current.get_children():
		current.remove_child(child)
		$viewport/static.add_child(child)
		current.queue_free()
		make_new()
		
func make_new():
	current = piece_scene.instantiate()
	current.type = randi_range(0,6)
	current.position = Vector2(150,0)
	$viewport.add_child(current)
	$Timer.start()



