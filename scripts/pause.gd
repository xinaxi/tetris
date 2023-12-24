extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		on_paused_pressed()

func on_paused_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible


