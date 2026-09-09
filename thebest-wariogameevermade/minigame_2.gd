extends Node2D
@onready var timer_node: Node = $ThemedTimer
var buttons_pressed := 0
var timer_end := false
var finished := false

func _ready() -> void:
	await timer_node.Timer(12.0)
	timer_end = true
	_finish(false)

func _process(_delta: float) -> void:
	if buttons_pressed >= 4:
		_finish(true)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		buttons_pressed += 1

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
	else:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
		
