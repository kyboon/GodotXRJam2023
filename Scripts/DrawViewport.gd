extends SubViewport

class_name DrawViewport

@export var brush: Sprite2D
@export var cal_vp: CalculationViewport
@export var progressLabel: Label3D

func move_brush(position: Vector2, brush_amount: float):
	render_target_update_mode = SubViewport.UPDATE_ONCE
	brush.self_modulate.a = brush_amount
	brush.position = position
	
	var progress = cal_vp.set_texture(get_texture())
	progressLabel.text = "Progress: %d%%" % roundi(progress * 100)
