extends SubViewport

class_name DrawViewport

signal progress_above_threshold()

@export var brush: Sprite2D
@export var cal_vp: CalculationViewport
@export var progress_label: Label3D
@export var time_label: Label3D
@export var highscore_label: Label3D
@export var black_bg: ColorRect

@export var mini_progress_label: Label3D
@export var mini_time_label: Label3D

@export var threshold: int = 90

const FILE_NAME = "user://clothes_steamer_hs.res"

var time_elapsed: float = -1
var high_score: int = -1

func _ready():
	high_score = load_high_score()
	if high_score > 0:
		var minutes = high_score / 60
		var seconds = high_score % 60
		highscore_label.text = "Highscore:\n%02d:%02d" % [minutes, seconds]

func _process(delta):
	if time_elapsed < 0:
		return
	time_elapsed += delta
	var seconds_rounded = roundi(time_elapsed)
	var minutes = seconds_rounded / 60
	var seconds = seconds_rounded % 60
	time_label.text = "Time:\n%02d:%02d" % [minutes, seconds]
	mini_time_label.text = "%02d:%02d" % [minutes, seconds]
	

func move_brush(position: Vector2, brush_amount: float, first: bool = false):
	render_target_update_mode = SubViewport.UPDATE_ONCE
	brush.self_modulate.a = brush_amount
	brush.position = position
	if !first:
		if time_elapsed < 0:
			time_elapsed = 0.01
		
		black_bg.visible = false
		
		var progress = cal_vp.set_texture(get_texture())
		var progress_rounded = roundi(progress * 100)
		progress_label.text = "Progress: %d%%" % progress_rounded
		mini_progress_label.text = "%d%%" % progress_rounded
	
		if progress_rounded >= threshold:
			var seconds_rounded = roundi(time_elapsed)
			if high_score < 0 || high_score > seconds_rounded:
				high_score = seconds_rounded
				save_high_score(seconds_rounded)
				var minutes = high_score / 60
				var seconds = high_score % 60
				highscore_label.text = "Highscore:\n%02d:%02d" % [minutes, seconds]
			progress_above_threshold.emit()
	else:
		time_elapsed = -1

func refresh():
	black_bg.visible = true
	render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
	render_target_update_mode = SubViewport.UPDATE_ONCE
	progress_label.text = "Progress: 0%"
	mini_progress_label.text = "0%"
	
	
func save_high_score(new_high_score: int):
	print("saving new high score ", new_high_score)
	var high_score_res = Score.new()
	high_score_res.high_score = new_high_score
	var save_result = ResourceSaver.save(high_score_res, FILE_NAME)
	print(save_result)
	
func load_high_score() -> int:
	print("loading high score")
	if ResourceLoader.exists(FILE_NAME):
		var score = ResourceLoader.load(FILE_NAME)
		if score is Score: # Check that the data is valid
			print("high score loaded")
			return score.high_score
			
	print("high score failed to load")
	return -1
