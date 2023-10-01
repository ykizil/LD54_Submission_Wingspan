extends Button

@export var scene : PackedScene

func _ready():
	pressed.connect(load_scene)

func load_scene():
	get_tree().change_scene_to_packed(scene)
