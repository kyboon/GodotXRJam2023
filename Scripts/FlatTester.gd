extends Node3D

@export var steamer: ClothesSteamer
@export var move_speed: float = 0.2
@export var fabric_spawner: Node
var current_m_vector: Vector3 = Vector3.ZERO
@export var parent_rb: RigidBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if current_m_vector != Vector3.ZERO:
		parent_rb.move_and_collide(current_m_vector * delta)
	pass
	
func _input(event):
	if event.is_action_pressed("move_left"):
		current_m_vector += Vector3.LEFT * move_speed
	elif event.is_action_released("move_left"):
		current_m_vector -= Vector3.LEFT * move_speed
		
	if event.is_action_pressed("move_right"):
		current_m_vector = Vector3.RIGHT * move_speed
	elif event.is_action_released("move_right"):
		current_m_vector -= Vector3.RIGHT * move_speed
		
	if event.is_action_pressed("move_forward"):
		current_m_vector = Vector3.FORWARD * move_speed
	elif event.is_action_released("move_forward"):
		current_m_vector -= Vector3.FORWARD * move_speed
		
	if event.is_action_pressed("move_backward"):
		current_m_vector = Vector3.BACK * move_speed
	elif event.is_action_released("move_backward"):
		current_m_vector -= Vector3.BACK * move_speed
		
	if event.is_action_pressed("move_up"):
		current_m_vector = Vector3.UP * move_speed
	elif event.is_action_released("move_up"):
		current_m_vector -= Vector3.UP * move_speed
		
	if event.is_action_pressed("move_down"):
		current_m_vector = Vector3.DOWN * move_speed
	elif event.is_action_released("move_down"):
		current_m_vector -= Vector3.DOWN * move_speed

	if event is InputEventKey and event.keycode == KEY_SPACE:
		steamer.set_pressing(event.is_pressed())
	
	if event is InputEventKey and event.keycode == KEY_SHIFT:
		steamer.set_hinting(event.is_pressed())
		
	if event is InputEventKey and event.keycode == KEY_2:
		if event.is_pressed():
			fabric_spawner.spawn_new_fabric()
