extends RayCast3D

@export var converter: Point2UVConverter
@export var brush_vp: DrawViewport
@export var fabric_mesh: MeshInstance3D

var pressing := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("\nFPS ", Engine.get_frames_per_second())
	
	if pressing and is_colliding():
		print("col norm ", get_collision_normal())
		print("col point ", get_collision_point())
		var uv_coords = converter.get_uv_coords(get_collision_point(), get_collision_normal())
		if uv_coords:
			print("uv ", uv_coords)
			brush_vp.move_brush(uv_coords * 512)
			#brush_vp
			var shader_mat = fabric_mesh.get_active_material(0) as ShaderMaterial
			if shader_mat:
				shader_mat.set_shader_parameter("paint_texture", brush_vp.get_texture())
	pass

func _input(event):
	if event is InputEventKey and event.keycode == KEY_SPACE:
		pressing = event.is_pressed()
