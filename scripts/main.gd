extends Node3D

@onready var meat_node: Node = $Meat;
@onready var blood_stains = $BloodStains;

var blood_scene = preload("res://scenes/blood.tscn");

func getallnodes(node):
	var signals = node.get_signal_list();
	for signal_entry in signals:
		if signal_entry["name"] == "spawn_blood":
			node.connect("spawn_blood", self._on_meat_spawn_blood);
			
	for N in node.get_children():
		if N.get_child_count() > 0:
			# print("["+N.get_name()+"]")
			getallnodes(N)
		else:
			# Do something
			#print("- "+N.get_name())
			#print(N.has_user_signal("spawn_blood"));
			pass


func _ready():
	var all_nodes = getallnodes(meat_node);
	
#	if meat_node.get_child_count() > 0:
#		for meat in meat_node.get_children():
#			meat.connect("spawn_blood", self._on_meat_spawn_blood);

func _process(delta):
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
