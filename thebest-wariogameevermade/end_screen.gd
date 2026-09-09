extends Node2D

@export var won := true

func _ready() -> void:
	$Message.text = "YOU WIN!" if won else "GAME OVER"
	$Details.text = "You collected every garlic!" if won else "The garlic got away..."

func _on_restart_pressed() -> void:
	Global.minigames_done = 0
	Global.lives = 5
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_restart_pressed()
