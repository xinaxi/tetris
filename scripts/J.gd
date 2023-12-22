extends Piece

func _init():
	type = forms.J
	color = "ff00ff"
	super()
	get_child(0).position.y -= 2*size
	get_child(1).position.y -= size
	get_child(3).position.x -= size

func _ready():
	super()
	position.y += 2*size
	position.x += size
