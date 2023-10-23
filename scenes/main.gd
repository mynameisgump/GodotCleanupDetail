extends Node3D

@onready var blood_stains = $BloodStains;

var blood_scene = preload("res://scenes/blood.tscn");

func _ready():
	pass 

func _process(delta):
	pass


func _on_meat_sphere_spawn_blood(pos, nor):
	var blood_stain: Blood = blood_scene.instantiate();
	blood_stains.add_child(blood_stain)
	blood_stain.set_position(pos)
	blood_stain.look_at(pos+nor,Vector3.UP)
	pass
