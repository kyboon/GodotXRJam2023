extends XRController3D

class_name Hand

var entered_steamer_head: SteamerHead
var attached_steamer_head: SteamerHead
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	print(body, " entered")
	if body is SteamerHead:
		entered_steamer_head = body


func _on_area_3d_body_exited(body):
	print(body, " exited")
	if body is SteamerHead and body == entered_steamer_head:
		entered_steamer_head = null

func _on_button_pressed(name):
	if name == "grip_click":
		if entered_steamer_head:
			if entered_steamer_head.attach(self): # if attach success
				attached_steamer_head = entered_steamer_head
	
	elif name == "trigger_click":
		if attached_steamer_head:
			attached_steamer_head.press_btn()


func _on_button_released(name):
	if name == "grip_click":
		if attached_steamer_head:
			attached_steamer_head.release(self)
	
	elif name == "trigger_click":
		if attached_steamer_head:
			attached_steamer_head.release_btn()
