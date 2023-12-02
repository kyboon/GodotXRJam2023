extends RayCast3D

class_name ClothesSteamer

@export var converter: Point2UVConverter
@export var draw_vp: DrawViewport
@export var fabric_mesh: MeshInstance3D
@export var particle: GPUParticles3D
@export var pressureCollisionShape: CollisionShape3D

@export var steam_strength: float = 3

var pressing := false
var hinting := false
var vp_size = 512

# Called when the node enters the scene tree for the first time.
func _ready():
	vp_size = draw_vp.get_texture().get_size().x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("\nFPS ", Engine.get_frames_per_second())
	
	if pressing and is_colliding():
		var uv_coords = converter.get_uv_coords(get_collision_point(), get_collision_normal())
		if uv_coords:
			#print("uv: ", uv_coords, uv_coords * vp_size)
			draw_vp.move_brush(uv_coords * vp_size, delta * steam_strength)
			var shader_mat = fabric_mesh.get_active_material(0) as ShaderMaterial
			if shader_mat:
				shader_mat.set_shader_parameter("paint_texture", draw_vp.get_texture())

func set_pressing(is_pressing: bool):
	particle.emitting = is_pressing
	pressureCollisionShape.disabled = !is_pressing
	pressing = is_pressing
	
func set_hinting(is_hinting: bool):
	hinting = is_hinting
	var shader_mat = fabric_mesh.get_active_material(0) as ShaderMaterial
	if shader_mat:
		shader_mat.set_shader_parameter("show_hint", hinting)
		
func set_grab(grabbing: bool):
	if grabbing and is_colliding():
		var uv_coords = converter.get_uv_coords(get_collision_point(), get_collision_normal())
		if uv_coords:
			uv_to_soft_point(uv_coords)
			pass

func uv_to_soft_point(uv: Vector2):
	var x_coords = 1 - uv.x
	var y_coords = 1 - uv.y
	var x_point = roundi(x_coords * 16)
	var y_point = roundi(y_coords * 16)
	var point_index = y_point * 17 + x_point
	print(uv)
	print("%d %d" % [x_point, y_point])
