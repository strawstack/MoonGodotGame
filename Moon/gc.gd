extends Node3D

@export var drink: Node3D

@export var wall_one: Node3D
@export var wall_two: Node3D
@export var roof: Node3D

var ap
var seen = {}
var goal = 0 # if three
var playOnce = true
var exitOnce = true

func _ready():
	ap = $AnimationPlayer
	$Audio/one_day_you.play()
	seen["door_one"] = true
	seen["door_two"] = true
	seen["leaving"] = true
	
	wall_one.visible = true
	wall_two.visible = true
	roof.visible = true

func showInteract(tag):
	if tag == null:
		$CanvasLayer.visible = false
	else:
		$CanvasLayer.visible = true
		$CanvasLayer/Label.set_text("Press E to interact with " + tag)

func interact(tag):

	# Don't trigger action more than once
	if tag in seen:
		return
	seen[tag] = true

	if tag == "door_one":
		ap.play(tag)
		$Audio/that_was_fast_one.play()

	if tag == "drink":
		drink.visible = false
		$Audio/that_drink.play()

	if tag == "brick":
		ap.play(tag)

	if tag == "fire":
		$Audio/a_small_rock.play()

	if tag == "door_two":
		ap.play(tag)
		$Audio/that_was_fast_two.play()
	
	if tag == "final":
		ap.play("fadeIn")

func playSacrifice():
	if playOnce:
		playOnce = false
		$Audio/sacrifice.play()

func _on_that_drink_finished():
	goal += 1
	if goal == 3:
		$Audio/you_can_leave.play()
		seen.erase("door_two")

func _on_sacrifice_finished():
	goal += 1
	if goal == 3:
		$Audio/you_can_leave.play()
		seen.erase("door_two")

func _on_a_small_rock_finished():
	goal += 1
	if goal == 3:
		$Audio/you_can_leave.play()
		seen.erase("door_two")

func _on_one_day_you_finished():
	seen.erase("door_one")

func leave():
	if exitOnce:
		exitOnce = false
		$Audio/remember_when.play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fadeIn":
		get_tree().change_scene_to_file("res://menu.tscn")
