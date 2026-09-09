extends TextureButton

@onready var self_area: Area2D = $Area2D
@onready var player_area: Area2D = $"../Player/Area2D"

signal garlic_collected
var collected := false

func _process(_delta: float) -> void:
	if not collected and visible and player_area.overlaps_area(self_area):
		_collect()

func _ready() -> void:
	pressed.connect(_collect)

func _collect() -> void:
	if collected or not visible:
		return
	collected = true
	hide()
	garlic_collected.emit()
