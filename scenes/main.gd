extends Node3D

@onready var blood_stains = $BloodStains;

var blood_scene = preload("res://scenes/blood.tscn");

func _ready():
	pass 

func _process(delta):
	pass


func _on_meat_sphere_spawn_blood(pos, nor):
	var blood_stain := blood_scene.instantiate();
	var random_y_rotation = randf_range(0,360);
	blood_stains.add_child(blood_stain)
	blood_stain.global_transform.origin = pos;
	blood_stain.rotate_y(deg_to_rad(random_y_rotation));
	blood_stain.basis.y = nor;
	blood_stain.basis.x = -blood_stain.basis.z.cross(-nor)
	blood_stain.basis = blood_stain.basis.orthonormalized()
	pass
