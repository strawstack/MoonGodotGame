extends Node3D

var scene

func _on_button_pressed():
	$level/Camera3D.visible = false
	$level/SpotLight3D.visible = false
	$level/CanvasLayer.visible = false
	$level/main.playStart()

func _ready():
	$level/SpotLight3D.visible = true
	$level/CanvasLayer/Button.visible = false
	scene = preload("res://main.tscn").instantiate()
	$level/CanvasLayer/Button.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	# Free mouse on esc
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
