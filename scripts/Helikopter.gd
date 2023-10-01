extends RigidBody2D

var movement_vector = Vector2.ZERO

var health = 100
var speed = 400

@export var ungravity_force = 2.0
@export var windage = Vector2.ZERO

var rope_input = 0
var rope_speed = 1

@export var rope : DampedSpringJoint2D
@export var cargo : Cargo
@onready var heli_sprite = $HeliSprite
@onready var rotor_sound = $RotorSound
@onready var restart_label = $RestartLabel

var controls_disabled = false
var total_weight = 0

func _ready():
	GlobalEventBus.rotor_destroyed.connect(on_rotor_destroyed)
	GlobalEventBus.cargo_delivered.connect(disable_controls)
	calculate_weight()

func _physics_process(delta):
	add_wind()
	if controls_disabled:
		return
	apply_vfx_sfx()
	counter_gravity()
	movement_control()
	rope_control()

func apply_vfx_sfx():
	heli_sprite.rotation = linear_velocity.x/1800.0
	rotor_sound.pitch_scale = 0.7 + (abs(linear_velocity.x)/600.0) - (linear_velocity.y/600.0)

func movement_control():
	movement_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	apply_central_force(movement_vector*speed)

func counter_gravity():
	apply_central_force(980*Vector2.UP*ungravity_force)

func add_wind():
	apply_central_force(windage)

func rope_control():
	rope_input = Input.get_action_strength("rope_down") - Input.get_action_strength("rope_up")
	rope.rest_length = clamp(rope.rest_length + rope_input*rope_speed,0,300)

func on_rotor_destroyed():
	controls_disabled = true
	if is_instance_valid(rope):
		rope.queue_free()
	lock_rotation = false
	rotor_sound.stop()
	restart_label.visible = true

func disable_controls():
	controls_disabled = true
	if is_instance_valid(rope):
		rope.queue_free()
	linear_damp = 6
	rotor_sound.pitch_scale = 0.5
	rotor_sound.volume_db *= 2

func calculate_weight():
	total_weight = self.mass + cargo.mass
