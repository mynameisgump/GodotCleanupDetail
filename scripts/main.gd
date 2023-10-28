extends Node3D

@onready var meat_node: Node = $Meat;
@onready var spawn_timer = $Timer;
@onready var blood_stains = $BloodStains;

var blood_scene = preload("res://scenes/blood.tscn");
var arm_scene = preload("res://scenes/skeleton_3d.tscn");


var total_arms = 5;
var total_meat;
func add_arm():
	var x = randf_range(-10,10);
	var z = randf_range(-10,10);
	var y = randf_range(5,6);
	var new_arm = arm_scene.instantiate();

	new_arm.position = Vector3(x,y,z);
	meat_node.add_child(new_arm);


func getallnodes(node):
	var signals = node.get_signal_list();
	for signal_entry in signals:
		if signal_entry["name"] == "spawn_blood":
			node.connect("spawn_blood", self._on_meat_spawn_blood);
			
	for N in node.get_children():
		if N.get_child_count() > 0:
			getallnodes(N)
		else:
			pass


func _ready():
	var all_nodes = getallnodes(meat_node);
	
func _process(delta):
	total_meat = meat_node.get_child_count();

	if spawn_timer.is_stopped() and total_meat < total_arms:
		add_arm();
		var all_nodes = getallnodes(meat_node);
		spawn_timer.start();
	pass

func _on_meat_spawn_blood(pos,nor):
	var blood_stain := blood_scene.instantiate();
	var random_y_rotation = randf_range(0,360);
	blood_stains.add_child(blood_stain)
	blood_stain.global_transform.origin = pos;
	blood_stain.rotate_y(deg_to_rad(random_y_rotation));
	blood_stain.basis.y = nor;
	blood_stain.basis.x = -blood_stain.basis.z.cross(-nor)
	blood_stain.basis = blood_stain.basis.orthonormalized()
