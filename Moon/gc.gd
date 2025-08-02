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
var audio 
var gameStart = false

func _ready():
	audio = get_tree().get_root().get_node("menu/Audio")
	ap = $AnimationPlayer
	seen["door_one"] = true
	seen["door_two"] = true
	seen["leaving"] = true
	
	wall_one.visible = true
	wall_two.visible = true
	roof.visible = true

func playStart():
	gameStart = true
	$CharacterBody3D/Pivot/Camera3D.current = true
	$CanvasLayer2.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	audio.get_node("one_day_you").play()

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
		audio.get_node("that_was_fast_one").play()
		$moon/Light2.shadow_enabled = true
		$GPUParticles3D.emitting = true

	if tag == "drink":
		drink.visible = false
		audio.get_node("that_drink").play()

	if tag == "brick":
		ap.play(tag)

	if tag == "fire":
		audio.get_node("a_small_rock").play()

	if tag == "door_two":
		ap.play(tag)
		audio.get_node("that_was_fast_two").play()
	
	if tag == "final":
		ap.play("fadeIn")

func playSacrifice():
	if playOnce:
		playOnce = false
		audio.get_node("sacrifice").play()

func _on_that_drink_finished():
	goal += 1
	if goal == 3:
		audio.get_node("you_can_leave").play()
		seen.erase("door_two")

func _on_sacrifice_finished():
	goal += 1
	if goal == 3:
		audio.get_node("you_can_leave").play()
		seen.erase("door_two")

func _on_a_small_rock_finished():
	goal += 1
	if goal == 3:
		audio.get_node("you_can_leave").play()
		seen.erase("door_two")

func _on_one_day_you_finished():
	$moon/Light3.shadow_enabled = true
	$moon/Light3.light_energy = 5.0
	seen.erase("door_one")

func leave():
	if exitOnce:
		exitOnce = false
		audio.get_node("remember_when").play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fadeIn":
		get_tree().change_scene_to_file("res://menu.tscn")
