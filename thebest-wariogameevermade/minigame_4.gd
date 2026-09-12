extends Node2D

@onready var timer_node: Node = $ThemedTimer
@onready var prompt_label: Label = $Prompt
@onready var status_label: Label = $Status

const TOTAL_STEPS := 8
const PROMPTS := ["UP", "RIGHT", "DOWN", "LEFT", "UP", "DOWN", "RIGHT", "LEFT"]
const PROMPT_SYMBOLS := ["↑", "→", "↓", "←"]

var current_step := 0
var timer_ended := false
var finished := false

func _ready() -> void:
	_show_prompt()
	_update_status("Follow the signal!")
	await timer_node.Timer(15.0)
	if finished:
		return
	timer_ended = true
	_finish(false)

func _unhandled_input(event: InputEvent) -> void:
	if finished:
		return
	if event.is_action_pressed("ui_up"):
		_try_direction("UP")
	elif event.is_action_pressed("ui_right"):
		_try_direction("RIGHT")
	elif event.is_action_pressed("ui_down"):
		_try_direction("DOWN")
	elif event.is_action_pressed("ui_left"):
		_try_direction("LEFT")

func _show_prompt() -> void:
	var prompt_index: String = PROMPTS[current_step]
	prompt_label.text = PROMPT_SYMBOLS[["UP", "RIGHT", "DOWN", "LEFT"].find(prompt_index)]

func _try_direction(direction: String) -> void:
	if direction == PROMPTS[current_step]:
		current_step += 1
		if current_step >= TOTAL_STEPS:
			_finish(true)
			return
		_show_prompt()
		_update_status("Nice! Keep climbing.")
	else:
		_update_status("Not that way — watch the arrow.")

func _on_up_pressed() -> void:
	_try_direction("UP")

func _on_right_pressed() -> void:
	_try_direction("RIGHT")

func _on_down_pressed() -> void:
	_try_direction("DOWN")

func _on_left_pressed() -> void:
	_try_direction("LEFT")

func _update_status(message: String) -> void:
	status_label.text = "%s\\nSignals matched: %d / %d    Lives: %d" % [message, current_step, TOTAL_STEPS, Global.lives]

func _finish(success: bool) -> void:
	if finished:
		return
	if not success and not timer_ended:
		return
	finished = true
	if not success:
		Global.minigames_done = maxi(0, Global.minigames_done - 1)
		Global.lives -= 1
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://level_scene.tscn")
	elif Global.minigames_done >= 4:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://level_scene.tscn")
