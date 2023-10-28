extends PhysicalBone3D

const GRAB_FORCE: int = 20;
var linear_vel = null;
var entered_blood = false;

func update_velocity(lv): 
	linear_vel = lv;

func _on_body_entered(body):
	pass 

func _ready():
	pass
	
func _integrate_forces(state):
	if linear_vel != null: state.linear_velocity = linear_vel * GRAB_FORCE;
