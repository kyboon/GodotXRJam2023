extends Node3D

@export var p2uv_converter: Point2UVConverter
@export var draw_viewport: DrawViewport

@export var fabric: Fabric
@export var spawn_wait_timer: Timer # timer to prevent spawning too frequently and infinite recursive (when threshold signal keep calling)
@export var success_particle: GPUParticles3D

@export var steamer: ClothesSteamer
@export var audio_player: AudioStreamPlayer3D

@export var completed_label: Label3D

@export var fabric_color_texs: Array[Texture2D]
@export var fabric_normal_texs: Array[Texture2D]

var last_spawned_fabric_index: int = -1
var spawning := false
var completed_count: int = 0

func _ready():
	p2uv_converter.set_mesh(fabric)
	spawn_new_fabric()
	
func spawn_new_fabric():
	if spawning:
		return
		
	print("Spawning new fabric")
	spawning = true
	spawn_wait_timer.start()
	var r = randi_range(0, fabric_color_texs.size() - 1)
	if r == last_spawned_fabric_index:
		r = (last_spawned_fabric_index + 1) % fabric_color_texs.size()
	fabric.set_fabric_tex(fabric_color_texs[r], fabric_normal_texs[r])
	last_spawned_fabric_index = r
	
	draw_viewport.refresh()
	draw_viewport.move_brush(Vector2.LEFT * 1000, 0, true)

func _on_draw_viewport_progress_above_threshold():
	if !spawning:
		spawn_new_fabric()
		success_particle.emitting = true
		completed_count += 1
		completed_label.text = "Completed\nClothes:\n%d" % completed_count
		steamer.set_pressing(false)
		audio_player.play()
		


func _on_timer_timeout():
	spawning = false
