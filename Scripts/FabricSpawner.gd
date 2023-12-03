extends Node3D

@export var p2uv_converter: Point2UVConverter
@export var steamer: ClothesSteamer
@export var draw_viewport: DrawViewport

var fabric_res: Resource = preload("res://Scenes/Fabric.tscn")
@export var current_fabric: Fabric

func _ready():
	spawn_new_fabric()
	
func spawn_new_fabric():
	if current_fabric:
		current_fabric.queue_free()
	
	current_fabric = fabric_res.instantiate()
	add_child(current_fabric)
	
	p2uv_converter.set_mesh(current_fabric)
	
	steamer.fabric = current_fabric
	
	draw_viewport.refresh()
	
