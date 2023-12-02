extends RayCast3D

class_name ClothesSteamer

@export var converter: Point2UVConverter
@export var draw_vp: DrawViewport
@export var fabric_mesh: MeshInstance3D
@export var particle: GPUParticles3D
@export var pressureCollisionShape: CollisionShape3D

@export var steam_strength: float = 3

var pressing := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("\nFPS ", Engine.get_frames_per_second())
	
	if pressing and is_colliding():
		var uv_coords = converter.get_uv_coords(get_collision_point(), get_collision_normal())
		if uv_coords:
			print("uv: ", uv_coords)
			draw_vp.move_brush(uv_coords * 512, delta * steam_strength)
			var shader_mat = fabric_mesh.get_active_material(0) as ShaderMaterial
			if shader_mat:
				shader_mat.set_shader_parameter("paint_texture", draw_vp.get_texture())
	pass

func set_pressing(is_pressing: bool):
	particle.emitting = is_pressing
	pressureCollisionShape.disabled = !is_pressing
	pressing = is_pressing
