extends Node3D

@onready var meat_node: Node = $Meat;
@onready var blood_stains = $BloodStains;

var blood_scene = preload("res://scenes/blood.tscn");
var arm_scene = preload("res://scenes/meat/arm.tscn");

var total_arms = 50;
func add_arm():
	var x = randf_range(-10,10);
	var z = randf_range(-10,10);
	var y = randf_range(5,30);
	#var impulse_x = randf_range(-1,1)*spawn_impulse_strength;
	#var impulse_z = randf_range(-1,1)*spawn_impulse_strength;

	var new_arm = arm_scene.instantiate();
	# new_arm.dissolve_time = current_dissolve_time;
	meat_node.add_child(new_arm);
	new_arm.set_position(Vector3(x,y,z));
	print("Postions:", new_arm.position)
	# new_arm.apply_impulse(Vector3(impulse_x,0,impulse_z))


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
	for n in 10:
		add_arm();

	
	var all_nodes = getallnodes(meat_node);
	
#	if meat_node.get_child_count() > 0:
#		for meat in meat_node.get_children():
#			meat.connect("spawn_blood", self._on_meat_spawn_blood);

func _process(delta):
	print(meat_node.get_child_count())
	pass

func _on_meat_spawn_blood(pos,nor):
	print("Spawning Blood")
	var blood_stain := blood_scene.instantiate();
	var random_y_rotation = randf_range(0,360);
	blood_stains.add_child(blood_stain)
	blood_stain.global_transform.origin = pos;
	blood_stain.rotate_y(deg_to_rad(random_y_rotation));
	blood_stain.basis.y = nor;
	blood_stain.basis.x = -blood_stain.basis.z.cross(-nor)
	blood_stain.basis = blood_stain.basis.orthonormalized()
