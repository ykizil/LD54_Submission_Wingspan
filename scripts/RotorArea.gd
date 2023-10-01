extends Area2D

var overlap_count = 0
var health_max = 1
var health = health_max
var rotor_destroyed = false
var immune = false

@onready var damage_sound = $RotorDamageSound
@onready var damage_particles = $Sparks

func _ready():
	GlobalEventBus.cargo_delivered.connect(on_delivered)

func _physics_process(delta):
	if overlap_count > 0 and rotor_destroyed == false and !immune:
		health -= delta
		GlobalEventBus.rotor_damaged.emit(100*health/health_max)
		GlobalEventBus.screen_shake_requested.emit(10*delta)
		damage_sound.playing = true
		damage_particles.emitting = true
		if health <= 0:
			GlobalEventBus.rotor_destroyed.emit()
			rotor_destroyed = true
	else:
		damage_sound.playing = false
		damage_particles.emitting = false

func on_delivered():
	immune = true

func _on_body_entered(body):
	overlap_count += 1

func _on_body_exited(body):
	overlap_count -= 1
