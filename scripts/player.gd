class_name Player
extends CharacterBody3D

var direction : Vector3;
var target_speed : Vector3;
var accel : float;
var hvel : Vector3;

@onready var body: Node3D = $PlayerBody;
@onready var head: Node3D = $PlayerBody/PlayerHead;
@onready var camera: Camera3D = $PlayerBody/PlayerHead/Camera3D;
@onready var grabber = $PlayerBody/PlayerHead/Grabber;
# Export Vars
@export var GRAVITY = 9.8;
@export var MAX_SPEED: float = 10.0;
@export var JUMP_SPEED = 500;
@export var ACCEL = 4.5;
@export var MAX_ACCEL = 150.0;
@export var DEACCEL= 0.86;
@export var MAX_SLOPE_ANGLE = 40;
@export var default_fov = 75;
@export var vac_max: int = 5;


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Speed Parameter
const SPEED = 7.0;
# Jump Velocity Parameter
const JUMP_VELOCITY = 10;
# Amount of directional control
const CONTROL : float = 15.0;

# Leaning Variables
var lean_left;
var lean_right;
var z_tilt = 0.0;
var z_tilt_target = 0.0;
var z_tilt_value = 0.01;
var LEAN_SPEED = 5;

var grabbed_item = null;
var grabbed_item_rel_pos= null;


func handle_grabber(): 
	if grabbed_item == null: 
		on_empty_grabber() 
	else: 
		on_full_grabber()

func on_empty_grabber(): 
	var collision_object = grabber.get_collider() 
	if collision_object != null: 
		on_grabber_collision(collision_object)

func on_full_grabber(): 
	var expected_translation = head.to_global(grabbed_item_rel_pos) 
	var linear_vel = expected_translation - grabbed_item.position 
	grabbed_item.update_velocity(linear_vel) 
	if Input.is_action_just_released("left_mouse"): 
		let_go();

func let_go(): 
	grabbed_item.update_velocity(null) 
	grabbed_item = null

func on_grabber_collision(collision_object): 
	if can_be_picked(collision_object): 
		if Input.is_action_just_pressed("left_mouse"): 
			grabbed_item_rel_pos = head.to_local(collision_object.position) 
			grabbed_item = collision_object 
			grabbed_item.apply_central_impulse(Vector3.UP * 0.5)

func can_be_picked(object): 
	return object.has_method("update_velocity") 


func is_moving():
	return Input.is_action_pressed("move_left") or \
	Input.is_action_pressed("move_right") or \
	Input.is_action_pressed("move_forward") or \
	Input.is_action_pressed("move_backward") 

func handle_input(delta : float) -> void:

	z_tilt_target = 0.0
	var cam_xform = camera.get_global_transform()

	if Input.is_action_pressed("move_left"):
		lean_left = true;
		z_tilt_target = z_tilt_value*5;
		
	if Input.is_action_pressed("move_right"):
		lean_right = true;
		z_tilt_target = -z_tilt_value*5;

func handle_movement(delta : float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	direction = lerp(direction, (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta * CONTROL)

	hvel = velocity
	hvel.y = 0.0
	hvel *= DEACCEL

	if hvel.length() < MAX_SPEED * 0.01:
		hvel = Vector3.ZERO

	var speed = hvel.dot(direction)

	var accel = clamp(MAX_SPEED - speed, 0.0, MAX_ACCEL * delta)
	hvel += direction * accel
	
	velocity.x = hvel.x
	velocity.z = hvel.z

	# Leaning code
	z_tilt += (z_tilt_target-z_tilt)*LEAN_SPEED*delta
	head.rotation.z = z_tilt

	move_and_slide()

func _physics_process(delta):
	handle_movement(delta)
	handle_input(delta)
	handle_grabber();
