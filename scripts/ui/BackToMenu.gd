extends Label

var active = false
@onready var main_menu = preload("res://scenes/ui/main_menu.tscn")
@onready var end_anim = $EndAnim

func _ready():
	pass

func _physics_process(delta):
	if active and Input.is_action_just_pressed("ui_select"):
		end_anim.play("FadeOut")

func activate():
	active = true

func load_menu():
	get_tree().change_scene_to_packed(main_menu)
