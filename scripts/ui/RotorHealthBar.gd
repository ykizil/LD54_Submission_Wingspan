extends ProgressBar

func _ready():
	GlobalEventBus.rotor_damaged.connect(update_value)

func update_value(amount):
	value = amount
