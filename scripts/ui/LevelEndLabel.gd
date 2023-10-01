extends Label

func _ready():
	GlobalEventBus.cargo_delivered.connect(on_delivery)

func on_delivery():
	visible = true
