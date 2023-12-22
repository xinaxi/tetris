extends Piece

func _init():
	type = forms.S
	color = "16c000"
	super()
	get_child(0).position = Vector2(size,-size)
	get_child(1).position.y -= size
	get_child(3).position.x -= size

func _ready():
	super()
	position.y += size
