extends SoftBody3D

class_name Fabric

var shader_mat: ShaderMaterial
# Called when the node enters the scene tree for the first time.
func _ready():
	shader_mat = get_active_material(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_hinting(is_hinting: bool):
	shader_mat.set_shader_parameter("show_hint", is_hinting)

func set_paint_tex(tex: Texture):
	shader_mat.set_shader_parameter("paint_texture", tex)
