extends Node3D

@export var p2uv_converter: Point2UVConverter
@export var steamer: ClothesSteamer
@export var draw_viewport: DrawViewport

var fabric_res: Resource = preload("res://Scenes/Fabric.tscn")
@export var current_fabric: Fabric

@export var fabric_color_texs: Array[Texture2D]
@export var fabric_normal_texs: Array[Texture2D]
var last_spawned_fabric_index: int = -1

func _ready():
	spawn_new_fabric()
	
func spawn_new_fabric():
	if current_fabric:
		current_fabric.queue_free()
	
	current_fabric = fabric_res.instantiate()
	add_child(current_fabric)
	
	var r = randi_range(0, fabric_color_texs.size() - 1)
	if r == last_spawned_fabric_index:
		r = (last_spawned_fabric_index + 1) % fabric_color_texs.size()
	current_fabric.set_fabric_tex(fabric_color_texs[r], fabric_normal_texs[r])
	last_spawned_fabric_index = r
	
	p2uv_converter.set_mesh(current_fabric)
	
	steamer.fabric = current_fabric
	
	draw_viewport.refresh()
	
