extends Piece

func _init():
	type = forms.L
	color = "ffff00"
	super()
	get_child(1).position.x = size
	get_child(2).position.y = -size
	get_child(3).position.y = -2*size

func _ready():
	super()
	position.y += 2*size
	
