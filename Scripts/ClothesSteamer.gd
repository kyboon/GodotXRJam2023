extends RayCast3D

class_name ClothesSteamer

@export var converter: Point2UVConverter
@export var draw_vp: DrawViewport
@export var fabric: Fabric
@export var particle: GPUParticles3D
@export var pressureCollisionShape: CollisionShape3D
@export var audio_player: AudioStreamPlayer3D

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
	if pressing and is_colliding():
		var uv_coords = converter.get_uv_coords(get_collision_point(), get_collision_normal())
		if uv_coords:
			draw_vp.move_brush(uv_coords * vp_size, delta * steam_strength)
			set_paint_tex(draw_vp.get_texture())

func set_pressing(is_pressing: bool):
	particle.emitting = is_pressing
	pressureCollisionShape.disabled = !is_pressing
	pressing = is_pressing
	if is_pressing:
		audio_player.play()
	else:
		audio_player.stop()
	
func set_paint_tex(tex: Texture):
	fabric.set_paint_tex(tex)
	
func set_hinting(is_hinting: bool):
	hinting = is_hinting
	fabric.set_hinting(is_hinting)
