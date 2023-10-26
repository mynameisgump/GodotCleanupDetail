extends PhysicalBone3D

# @onready var blood_timer: Timer = $BloodTimer

signal spawn_blood(pos: Vector3,nor: Vector3);

var Blood = preload("res://scenes/blood.tscn");

const GRAB_FORCE: int = 20;
var linear_vel = null;
var entered_blood = false;
var overlapping = []
var max_overlapping = 1;

func update_velocity(lv): 
	linear_vel = lv;

func _on_body_entered(body):
	pass # Replace with function body.

func _ready():
	
	print("Yay bone")
	
func _integrate_forces(state):
	if linear_vel != null: state.linear_velocity = linear_vel * GRAB_FORCE;

	# Blood Stain Code
	var total_contacts = state.get_contact_count();

	if total_contacts > 0 and overlapping.size() <= max_overlapping:
		var colliding_object = state.get_contact_collider_object(0);
		if colliding_object.name != "Player":
			var pos = state.get_contact_collider_position(0);
			var nor: Vector3 = state.get_contact_local_normal(0);
			spawn_blood.emit(pos,nor);
			#blood_timer.start();


#func _process(delta):
#	print("Bonin")
#	pass
