extends SubViewport

class_name DrawViewport

signal progress_above_threshold

@export var brush: Sprite2D
@export var cal_vp: CalculationViewport
@export var progress_label: Label3D
@export var black_bg: ColorRect

@export var threshold: int = 90

func move_brush(position: Vector2, brush_amount: float, first: bool = false):
	render_target_update_mode = SubViewport.UPDATE_ONCE
	if !first:
		black_bg.visible = false
	brush.self_modulate.a = brush_amount
	brush.position = position
	
	var progress = cal_vp.set_texture(get_texture())
	var progress_rounded = roundi(progress * 100)
	progress_label.text = "Progress: %d%%" % progress_rounded
	if progress_rounded >= threshold:
		progress_above_threshold.emit()

func refresh():
	black_bg.visible = true
	render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
	render_target_update_mode = SubViewport.UPDATE_ONCE
	progress_label.text = "Progress: 0%"
