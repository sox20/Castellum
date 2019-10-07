extends KinematicBody

const GRAVITY = -30
const MAX_SPEED = 7
const JUMP_SPEED = 10
const ACCELERATION = 10.0
const DEACCELERATION = 32
const MAX_SLOPE = 40

var velocity = Vector3()
var direction = Vector3()

var camera
var rotation_help
var mouse_sensitivity = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	
	camera = $rotation_help/Camera
	rotation_help = $rotation_help
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	#Walking
	direction = Vector3()
	var cam_xform = camera.get_global_transform()
	var input_movement_vector = Vector2()
	
	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1
	
	input_movement_vector = input_movement_vector.normalized()
	
	direction += -cam_xform.basis.z * input_movement_vector.y
	direction += cam_xform.basis.x * input_movement_vector.x
	
	#Jump
	if is_on_floor():
		if Input.is_action_pressed("movement_jump"):
			velocity.y = JUMP_SPEED

	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func process_movement(delta):
	direction.y = 0
	direction = direction.normalized()
	
	velocity.y += delta * GRAVITY
	
	
	var hvel = velocity
	hvel.y = 0
	
	var target = direction
	target *= MAX_SPEED
	
	var accel
	if direction.dot(hvel) > 0:
		accel = ACCELERATION
	else:
		accel = DEACCELERATION
	
	hvel = hvel.linear_interpolate(target, accel * delta)
	velocity.x = hvel.x
	velocity.z = hvel.z
	velocity = move_and_slide(velocity, Vector3(0,1,0), 0.05, 4, deg2rad(MAX_SLOPE))
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_help.rotate_x(deg2rad(event.relative.y * mouse_sensitivity * -1))
		self.rotate_y(deg2rad(event.relative.x * mouse_sensitivity * -1))
		
		var camera_rot = rotation_help.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_help.rotation_degrees = camera_rot
