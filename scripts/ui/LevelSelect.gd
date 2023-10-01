extends Button

func _ready():
	pressed.connect(toggle_levels)

func toggle_levels():
	%"LevelList".visible = !%"LevelList".visible
