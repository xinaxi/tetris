extends Piece

func _init():
	type = forms.T
	color = "002fff"
	super()
	get_child(0).position.x = -size
	get_child(2).position.x = size
	get_child(3).position.y = size


