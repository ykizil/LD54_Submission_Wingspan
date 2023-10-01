extends Button

@onready var anim = $AnimationPlayer
@onready var lv1 = load("res://scenes/levels/level_1.tscn")

func on_pressed():
	anim.play("new_game")

func load_lv1():
	get_tree().change_scene_to_packed(lv1)
