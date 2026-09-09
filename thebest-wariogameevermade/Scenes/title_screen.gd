extends Node2D

var settings_panel: Control

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

func _on_settings_pressed() -> void:
	if is_instance_valid(settings_panel):
		return
	$Title.hide()
	$VBoxContainer.hide()
	settings_panel = ColorRect.new()
	settings_panel.name = "SettingsPanel"
	settings_panel.color = Color(0.03, 0.04, 0.12, 0.92)
	settings_panel.position = Vector2.ZERO
	settings_panel.size = get_viewport_rect().size
	settings_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(settings_panel)

	var center := CenterContainer.new()
	center.position = Vector2.ZERO
	center.size = get_viewport_rect().size
	settings_panel.add_child(center)
	var box := VBoxContainer.new()
	box.custom_minimum_size = Vector2(520, 0)
	box.add_theme_constant_override("separation", 14)
	center.add_child(box)
	var heading := Label.new()
	heading.text = "Settings"
	heading.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	heading.add_theme_font_size_override("font_size", 48)
	box.add_child(heading)
	var instructions := Label.new()
	instructions.text = "Keyboard: A/D or arrow keys to move, W/Space to jump.\nMouse: use the on-screen controls during the platformer.\nClick every garlic target in the second minigame."
	instructions.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	instructions.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	instructions.add_theme_font_size_override("font_size", 22)
	box.add_child(instructions)
	var back := Button.new()
	back.text = "Back to Title"
	back.custom_minimum_size = Vector2(360, 56)
	back.add_theme_font_size_override("font_size", 24)
	back.pressed.connect(_close_settings)
	box.add_child(back)

func _close_settings() -> void:
	if is_instance_valid(settings_panel):
		settings_panel.queue_free()
		settings_panel = null
	$Title.show()
	$VBoxContainer.show()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_start_pressed()

func _on_quit_pressed() -> void:
	get_tree().quit()
