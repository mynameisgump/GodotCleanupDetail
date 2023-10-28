extends RigidBody3D

const GRAB_FORCE: int = 20;
var linear_vel = null;

func update_velocity(lv): 
	linear_vel = lv;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _integrate_forces(state):
	if linear_vel != null: state.linear_velocity = linear_vel * GRAB_FORCE;
