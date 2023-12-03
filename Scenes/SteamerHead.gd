extends RigidBody3D

class_name SteamerHead

var attached_hand: Hand

@export var hint_label: Label3D
@export var hint_timer: Timer

@export var steamer: ClothesSteamer

var show_hint_hint = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attached_hand:
		global_position = attached_hand.global_position
		rotation = attached_hand.rotation

func attach(hand) -> bool:
	print("attach to ", hand)
	if attached_hand:
		return false
	else:
		attached_hand = hand
		hint_label.text = "Press trigger to emit steam"
		hint_timer.start()
		return true

func release(hand):
	print("release from ", hand)
	if hand == attached_hand:
		attached_hand = null
		steamer.set_hinting(false)
		steamer.set_pressing(false)
		hint_label.text = "Press grip to grab"
		hint_label.visible = true
		show_hint_hint = false
	
func press_btn():
	steamer.set_pressing(true)
	
func release_btn():
	steamer.set_pressing(false)
	
func press_hint():
	steamer.set_hinting(true)
	
func release_hint():
	steamer.set_hinting(false)


func _on_timer_timeout():
	if !show_hint_hint:
		hint_label.text = "Press face button\nto show hint"
		hint_timer.start()
		show_hint_hint = true
	else:
		hint_label.visible = false
