extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
@onready var player: CharacterBody2D = $Player
@onready var status_label: Label = $Controls/Panel/Status
var garlic_collected := 0
var timer_end := false
var finished := false

func _ready() -> void:
	for garlic in [$Garlic, $Garlic2, $Garlic3]:
		garlic.garlic_collected.connect(_on_garlic_collected)
	_update_status()
	await themed_timer.Timer(10.0)
	timer_end = true
	_finish(false)

func _on_garlic_collected() -> void:
	garlic_collected += 1
	_update_status()
	if garlic_collected >= 3:
		_finish(true)

func _update_status() -> void:
	status_label.text = "Garlic: %d / 3    Lives: %d" % [garlic_collected, Global.lives]

func _on_left_button_down() -> void:
	player.set_mobile_direction(-1.0)

func _on_left_pressed() -> void:
	player.nudge_mobile_direction(-1.0)

func _on_right_button_down() -> void:
	player.set_mobile_direction(1.0)

func _on_right_pressed() -> void:
	player.nudge_mobile_direction(1.0)

func _on_move_button_up() -> void:
	player.clear_mobile_direction()

func _on_jump_pressed() -> void:
	player.request_mobile_jump()

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
	elif Global.minigames_done >= 4:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://level_scene.tscn")
