extends RigidBody3D

class_name SteamerHead

var attached_hand: Hand

@export var steamer: ClothesSteamer
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
		return true

func release(hand):
	print("release from ", hand)
	if hand == attached_hand:
		attached_hand = null
	
func press_btn():
	steamer.set_pressing(true)
	
func release_btn():
	steamer.set_pressing(false)
