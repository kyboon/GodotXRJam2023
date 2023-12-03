extends SubViewport

class_name DrawViewport

@export var brush: Sprite2D
@export var cal_vp: CalculationViewport
@export var progress_label: Label3D
@export var black_bg: ColorRect

func move_brush(position: Vector2, brush_amount: float):
	render_target_update_mode = SubViewport.UPDATE_ONCE
	black_bg.visible = false
	brush.self_modulate.a = brush_amount
	brush.position = position
	
	var progress = cal_vp.set_texture(get_texture())
	progress_label.text = "Progress: %d%%" % roundi(progress * 100)

func refresh():
	black_bg.visible = true
	render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
	render_target_update_mode = SubViewport.UPDATE_ONCE
	progress_label.text = "Progress: 0%"
