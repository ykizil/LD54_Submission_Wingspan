extends Area2D

@onready var anim = $CargoTargetAnimation
@onready var zone_sprite = $CargoZoneSprite
@onready var victory_sfx = $VictoryJingle
@export var next_scene : PackedScene
@onready var main_menu = load("res://scenes/ui/main_menu.tscn")

var game_complete = false

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(main_menu)
	if game_complete and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_packed(next_scene)

func _on_body_entered(body):
	if body is Cargo:
		GlobalEventBus.cargo_delivered.emit()
		anim.play("cargo_delivered")
		game_complete = true
		zone_sprite.visible = false
		victory_sfx.play()
