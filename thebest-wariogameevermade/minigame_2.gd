extends Node2D
@onready var timer_node: Node = $ThemedTimer
@onready var status_label: Label = $Status
var buttons_pressed := 0
var last_buttons_pressed := -1
var timer_end := false
var finished := false

func _ready() -> void:
	_update_status()
	await timer_node.Timer(12.0)
	timer_end = true
	_finish(false)

func _process(_delta: float) -> void:
	if buttons_pressed != last_buttons_pressed:
		_update_status()
	if buttons_pressed >= 4:
		_finish(true)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and buttons_pressed < 4:
		buttons_pressed += 1

func _update_status() -> void:
	last_buttons_pressed = buttons_pressed
	status_label.text = "Garlic: %d / 4    Lives: %d" % [buttons_pressed, Global.lives]

func _finish(success: bool) -> void:
	if finished:
		return
	if not success and not timer_end:
		return
	finished = true
	if not success:
		Global.minigames_done -= 1
		Global.lives -= 1
		if Global.lives <= 0:
			get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://level_scene.tscn")
	elif Global.lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
	elif Global.minigames_done >= 4:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://level_scene.tscn")
		
