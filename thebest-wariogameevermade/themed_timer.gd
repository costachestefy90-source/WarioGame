extends Node2D
@onready var timer: RichTextLabel = $Timer
var time

func Timer(start_time: float) -> void:
	time = start_time
	while time > 0.0:
		timer.text = str(snapped(time, 0.10))
		await wait(0.10)
		time -= 0.10

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
