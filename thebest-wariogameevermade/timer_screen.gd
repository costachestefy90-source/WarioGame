extends Node2D
@onready var garlic_container: HBoxContainer = $GarlicContainer
@onready var garlic: TextureRect = $GarlicContainer/Garlic
@onready var garlic_2: TextureRect = $GarlicContainer/Garlic2
@onready var garlic_3: TextureRect = $GarlicContainer/Garlic3
@onready var garlic_4: TextureRect = $GarlicContainer/Garlic4
@onready var garlic_5: TextureRect = $GarlicContainer/Garlic5
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer
var time := 5.0

func _ready() -> void:
    level.text = "Level " + str(Global.minigames_done + 1)
    while time > 0.0:
        timer.text = str(snapped(time, 0.1))
        await get_tree().create_timer(0.1).timeout
        time -= 0.1

    if Global.minigames_done < 2:
        Global.minigames_done += 1
        get_tree().change_scene_to_file("res://minigame_" + str(Global.minigames_done) + ".tscn" if Global.minigames_done == 1 else "res://Minigame_2.tscn")

func _process(_delta: float) -> void:
    match Global.lives:
        4:
            garlic.hide()
        3:
            garlic.hide()
            garlic_2.hide()
        2:
            garlic.hide()
            garlic_2.hide()
            garlic_3.hide()
        1:
            garlic.hide()
            garlic_2.hide()
            garlic_3.hide()
            garlic_4.hide()
        0:
            garlic_container.hide()
		
