extends Node2D

@onready var timer_node: Node = $ThemedTimer
@onready var target: Button = $Target
@onready var status_label: Label = $Status

const TARGETS_TO_CATCH := 5
const TARGET_POSITIONS := [
	Vector2(120, 170),
	Vector2(470, 150),
	Vector2(820, 175),
	Vector2(270, 390),
	Vector2(650, 420),
	Vector2(930, 370),
]
const TARGET_ROTATIONS := [-8.0, 6.0, -5.0, 8.0, -6.0, 4.0]

var targets_caught := 0
var position_index := 0
var move_clock := 0.0
var timer_ended := false
var finished := false

func _ready() -> void:
	_place_target()
	_update_status()
	await timer_node.Timer(15.0)
	if finished:
		return
	timer_ended = true
	_finish(false)

func _process(delta: float) -> void:
	if finished:
		return
	move_clock += delta
	if move_clock >= 1.0:
		move_clock = 0.0
		_place_target()

func _place_target() -> void:
	var slot := position_index % TARGET_POSITIONS.size()
	target.position = TARGET_POSITIONS[slot]
	target.rotation = deg_to_rad(TARGET_ROTATIONS[slot])
	position_index += 1

func _on_target_pressed() -> void:
	if finished:
		return
	targets_caught += 1
	_update_status()
	if targets_caught >= TARGETS_TO_CATCH:
		_finish(true)
	else:
		_place_target()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_target_pressed()

func _update_status() -> void:
	status_label.text = "Stars caught: %d / %d    Lives: %d" % [targets_caught, TARGETS_TO_CATCH, Global.lives]

func _finish(success: bool) -> void:
	if finished:
		return
	if not success and not timer_ended:
		return
	finished = true
	target.disabled = true
	if not success:
		Global.minigames_done = maxi(0, Global.minigames_done - 1)
		Global.lives -= 1
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://level_scene.tscn")
	elif Global.minigames_done >= 3:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://level_scene.tscn")
