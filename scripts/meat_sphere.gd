class_name MeatSphere
extends RigidBody3D

@onready var blood_timer: Timer = $BloodTimer

signal spawn_blood(pos: Vector3,nor: Vector3);

var Blood = preload("res://scenes/blood.tscn");

func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body: StaticBody3D):
	pass 

func _integrate_forces(state):
	var total_contacts = state.get_contact_count();
	if total_contacts > 0 and blood_timer.is_stopped():
		print(state.get_contact_local_position(0));
		var pos = state.get_contact_collider_position(0);
		var nor = state.get_contact_collider_position(0)
		var contact_point = self.global_position-0.5*nor
		spawn_blood.emit(pos,nor)
		blood_timer.start();
		

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
