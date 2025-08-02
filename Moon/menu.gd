extends Node3D

var scene

func _on_button_pressed():
	var children = $level.get_children()
	for child in children:
		child.queue_free()
	$level.add_child(scene)

func _ready():
	$level/CanvasLayer/Button.visible = false
	scene = preload("res://main.tscn").instantiate()
	$level/CanvasLayer/Button.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	# Free mouse on esc
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
