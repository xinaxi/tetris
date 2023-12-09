extends Piece

func _init():
	type = forms.Z
	color = "c77fff"
	super()
	get_child(0).position = Vector2(-size,-size)
	get_child(1).position.y -= size
	get_child(3).position.x += size


