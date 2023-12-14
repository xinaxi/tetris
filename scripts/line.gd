extends Piece

func _init():
	type = forms.LINE
	color = "008aff"
	super()
	get_child(0).position.x -= size
	get_child(1).position.x += size
	get_child(3).position.x += 2*size


