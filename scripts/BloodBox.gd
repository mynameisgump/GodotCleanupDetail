extends Area3D

@onready var blood_timer: Timer = $BloodTimer_2

signal spawn_blood(pos: Vector3,nor: Vector3);

var Blood = preload("res://scenes/blood.tscn");


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	var total_contacts = state.get_contact_count();
	print("BloodBoxContacts")
	if total_contacts > 0 and blood_timer.is_stopped():
		var pos = state.get_contact_collider_position(0);
		var nor = state.get_contact_local_normal(0);
		print("Blood Box:",pos,nor)
		spawn_blood.emit(pos,nor)
		blood_timer.start();
		
