extends Node2D

func _ready() -> void:
	$Actors/Camera/Aperture.material_override.set_shader_parameter("BACKGROUND",$Backdrop.texture)
	var stage_set = $Stage.get_texture()
	$Actors/Camera/Aperture.material_override.set_shader_parameter("GEOMETRY",stage_set)
