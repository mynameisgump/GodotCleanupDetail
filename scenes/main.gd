extends Node3D

@onready var blood_stains = $BloodStains;

var blood_scene = preload("res://scenes/blood.tscn");

func _ready():
	pass 

func _process(delta):
	pass


func _on_meat_sphere_spawn_blood(pos, nor):
	var blood_stain := blood_scene.instantiate();
	blood_stains.add_child(blood_stain)
	blood_stain.global_transform.origin = pos;
	blood_stain.basis.y = nor;
	blood_stain.basis.x = -blood_stain.basis.z.cross(-nor)
	#blood_stain.global_transform.basis = nor;
	#blood_stain.look_at(pos+Vector3.UP,Vector3.UP)
	pass
