extends Button

@onready var anim = $AnimationPlayer

func _ready():
	pressed.connect(on_pressed)

func on_pressed():
	anim.play("leave")

func quit():
	get_tree().quit(128)
