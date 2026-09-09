extends Node2D

func _ready() -> void:
	var viewport_size := get_viewport_rect().size
	$VBoxContainer.position = Vector2((viewport_size.x - 240.0) / 2.0, viewport_size.y * 0.52)
	$VBoxContainer.size = Vector2(240.0, 190.0)
	for button in $VBoxContainer.get_children():
		button.custom_minimum_size = Vector2(240.0, 52.0)

func _on_start_pressed() -> void:
	Global.minigames_done = 0
	Global.lives = 5
	get_tree().change_scene_to_file("res://level_scene.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_start_pressed()

func _on_quit_pressed() -> void:
	get_tree().quit()
