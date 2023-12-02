extends SubViewport

class_name DrawViewport

@export var brush: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_brush(position: Vector2, brush_amount: float):
	render_target_update_mode = SubViewport.UPDATE_ONCE
	brush.self_modulate.a = brush_amount
	brush.position = position
	
func brush_size():
	return brush.texture.get_height()
