extends TextureRect

@onready var self_area: Area2D = $Area2D
@onready var player_area: Area2D = $"../Player/Area2D"

signal garlic_collected

func _process(_delta: float) -> void:
	if visible and player_area.overlaps_area(self_area):
		garlic_collected.emit()
		hide()
