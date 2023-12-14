extends Piece

func _init():
	type = forms.CUBE
	color = "e89600"
	super()
	get_child(1).position = Vector2(0,size)
	get_child(2).position = Vector2(size,0)
	get_child(3).position = Vector2(size,size)

func rotate_piece():
	pass
