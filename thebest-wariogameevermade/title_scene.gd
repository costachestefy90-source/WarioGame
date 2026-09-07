extends TextureRect
var runtime_ui: Control
var timer: Timer
var time_left := 15
var score := 0
var lives := 3
var level := 1
var challenge_progress := 0
var status_label: Label

func _ready() -> void: hide_existing_nodes(); show_title_screen()
func hide_existing_nodes() -> void: if has_node("Title"): get_node("Title").hide(); if has_node("Button"): get_node("Button").hide(); if has_node("Button2"): get_node("Button2").hide(); if has_node("Button3"): get_node("Button3").hide()
func free_runtime() -> void: if is_instance_valid(runtime_ui): runtime_ui.queue_free()
func clear_runtime() -> void: free_runtime(); runtime_ui = Control.new(); runtime_ui.name = "RuntimeUI"; runtime_ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); add_child(runtime_ui)
func make_box() -> VBoxContainer: var center := CenterContainer.new(); center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT); runtime_ui.add_child(center); var box := VBoxContainer.new(); box.add_theme_constant_override("separation", 16); box.custom_minimum_size = Vector2(360, 0); center.add_child(box); return box
func make_label(text_value: String, size: int) -> Label: var label := Label.new(); label.text = text_value; label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; label.add_theme_font_size_override("font_size", size); return label
func make_button(text_value: String) -> Button: var button := Button.new(); button.text = text_value; button.custom_minimum_size = Vector2(360, 64); button.add_theme_font_size_override("font_size", 24); return button
func stop_timer() -> void: if is_instance_valid(timer): timer.stop()
func show_title_screen() -> void: stop_timer(); clear_runtime(); var box := make_box(); box.add_child(make_label("WarioWare", 64)); box.add_child(make_label("Mountain Challenge", 24)); var start_button := make_button("Start Game"); start_button.pressed.connect(start_game); box.add_child(start_button); var settings_button := make_button("Settings"); settings_button.pressed.connect(show_settings); box.add_child(settings_button); var quit_button := make_button("Quit"); quit_button.pressed.connect(quit_game); box.add_child(quit_button)
func show_settings() -> void: clear_runtime(); var box := make_box(); box.add_child(make_label("Settings", 48)); box.add_child(make_label("Fast rounds, three lives, and a mountain finish.", 20)); var back_button := make_button("Back to Title"); back_button.pressed.connect(show_title_screen); box.add_child(back_button)
func quit_game() -> void: get_tree().quit()
func start_game() -> void: level = 1; score = 0; lives = 3; challenge_progress = 0; start_clicker_level()
func dispose_timer() -> void: if is_instance_valid(timer): timer.queue_free()
func setup_timer() -> void: dispose_timer(); timer = Timer.new(); timer.wait_time = 1.0; timer.timeout.connect(tick_timer); add_child(timer); time_left = 15; timer.start()
func start_clicker_level() -> void: clear_runtime(); var box := make_box(); box.add_child(make_label("Level 1: Clicker", 42)); status_label = make_label("", 22); box.add_child(status_label); box.add_child(make_label("Tap the treasure twelve times!", 20)); var click_button := make_button("CLICK THE TREASURE!"); click_button.add_theme_font_size_override("font_size", 28); click_button.pressed.connect(click_target); box.add_child(click_button); var menu_button := make_button("Return to Title"); menu_button.pressed.connect(show_title_screen); box.add_child(menu_button); setup_timer(); update_status()
func click_target() -> void: score += 1; challenge_progress += 1; update_status(); if challenge_progress >= 12: start_platformer_level()
func start_platformer_level() -> void: level = 2; challenge_progress = 0; clear_runtime(); var box := make_box(); box.add_child(make_label("Level 2: Platformer", 42)); status_label = make_label("", 22); box.add_child(status_label); box.add_child(make_label("Press JUMP six times to reach the summit.", 20)); var jump_button := make_button("JUMP"); jump_button.add_theme_font_size_override("font_size", 30); jump_button.pressed.connect(jump_player); box.add_child(jump_button); var menu_button := make_button("Return to Title"); menu_button.pressed.connect(show_title_screen); box.add_child(menu_button); setup_timer(); update_status()
func jump_player() -> void: challenge_progress += 1; score += 2; update_status(); if challenge_progress >= 6: show_winner_screen()
func tick_timer() -> void: time_left -= 1; update_status(); if time_left <= 0: lives -= 1; challenge_progress = 0; if lives <= 0: show_death_screen(); time_left = 15
func update_status() -> void: if is_instance_valid(status_label): if level == 1: status_label.text = "Time: %d    Score: %d    Lives: %d" % [time_left, score, lives]; if level != 1: status_label.text = "Time: %d    Jumps: %d / 6    Score: %d" % [time_left, challenge_progress, score]
func show_winner_screen() -> void: stop_timer(); clear_runtime(); var box := make_box(); box.add_child(make_label("YOU WIN!", 64)); box.add_child(make_label("Summit reached with score %d" % score, 24)); var again := make_button("Play Again"); again.pressed.connect(start_game); box.add_child(again); var home := make_button("Back to Title"); home.pressed.connect(show_title_screen); box.add_child(home)
func show_death_screen() -> void: stop_timer(); clear_runtime(); var box := make_box(); box.add_child(make_label("TRY AGAIN", 60)); box.add_child(make_label("The mountain got the best of you.", 24)); var again := make_button("Retry"); again.pressed.connect(start_game); box.add_child(again); var home := make_button("Back to Title"); home.pressed.connect(show_title_screen); box.add_child(home)

	 
