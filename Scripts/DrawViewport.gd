extends SubViewport

class_name DrawViewport

signal progress_above_threshold()

@export var brush: Sprite2D
@export var cal_vp: CalculationViewport
@export var progress_label: Label3D
@export var time_label: Label3D
@export var black_bg: ColorRect

@export var threshold: int = 90

var time_elapsed: float = -1

func _process(delta):
	if time_elapsed < 0:
		return
	time_elapsed += delta
	var seconds_rounded = roundi(time_elapsed)
	var minutes = seconds_rounded / 60
	var seconds = seconds_rounded % 60
	time_label.text = "Time:\n%02d:%02d" % [minutes, seconds]
	

func move_brush(position: Vector2, brush_amount: float, first: bool = false):
	render_target_update_mode = SubViewport.UPDATE_ONCE
	brush.self_modulate.a = brush_amount
	brush.position = position
	if !first:
		if time_elapsed < 0:
			time_elapsed = 0
		
		black_bg.visible = false
		
		var progress = cal_vp.set_texture(get_texture())
		var progress_rounded = roundi(progress * 100)
		progress_label.text = "Progress: %d%%" % progress_rounded
	
		if progress_rounded >= threshold:
			progress_above_threshold.emit()
	else:
		time_elapsed = -1
		time_label.text = "Time:\n00:00"

func refresh():
	black_bg.visible = true
	render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
	render_target_update_mode = SubViewport.UPDATE_ONCE
	progress_label.text = "Progress: 0%"
