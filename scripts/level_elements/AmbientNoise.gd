extends AudioStreamPlayer

var sound_env = "wind" #MAKARNA, bunun için mapin ozelliklerini bi yere kayedip ordan cek (bi dahakine)

func _ready():
	sound_env = stream.resource_path.get_file().get_basename()
	if sound_env == "wind":
		AudioServer.get_bus_effect(0,0).set_dry(0.98)
		AudioServer.get_bus_effect(0,0).set_wet(0.02)
	elif sound_env == "cave":
		AudioServer.get_bus_effect(0,0).set_dry(0.8)
		AudioServer.get_bus_effect(0,0).set_wet(0.2)
