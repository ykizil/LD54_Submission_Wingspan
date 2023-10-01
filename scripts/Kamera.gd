extends Camera2D

var camera_shake = 0

func _ready():
	GlobalEventBus.cargo_crashed.connect(add_shake)
	GlobalEventBus.screen_shake_requested.connect(add_shake)

func _process(delta):
	offset.x = camera_shake*randf_range(-1,1)
	offset.y = camera_shake*randf_range(-1,1)
	recover_shake(delta)

func add_shake(amount):
	camera_shake += amount

func recover_shake(delta):
	camera_shake *= (1-delta*10)
