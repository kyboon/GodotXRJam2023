extends RayCast3D

@export var converter: Point2UVConverter

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("\nFPS ", Engine.get_frames_per_second())
	if is_colliding():
		print("col norm ", get_collision_normal())
		print("col point ", get_collision_point())
		var uv_coords = converter.get_uv_coords(get_collision_point(), get_collision_normal())
		if uv_coords:
			print("uv ", uv_coords)
	pass
