extends RigidBody2D

class_name Cargo
@onready var sfx = $CargoSFX
var contact_count = 0

func _ready():
	GlobalEventBus.cargo_delivered.connect(on_delivered)

func on_delivered():
	set_deferred("freeze",true)

func _integrate_forces(state):
	var contact_force = 0
	
	for i in range(get_contact_count()):
		var new_contact_force = state.get_contact_impulse(i).length()
		contact_force = clamp(max(contact_force,new_contact_force),0,80)

	if contact_force > 10:
		GlobalEventBus.cargo_crashed.emit(contact_force*0.03)
		if !sfx.playing:
			sfx.play()
			sfx.volume_db = clamp((-80+contact_force)/4,-80,-6)

