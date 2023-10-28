class_name Sponge
extends CharacterBody3D

@onready var sponge_mesh = $SpongeMesh;
var current_blood = 0.0;
var max_blood = 10.0;

func set_color():
	var color_val = (current_blood/max_blood);
	print(color_val)
	var material: StandardMaterial3D  = sponge_mesh.get_surface_override_material(0);
	material.albedo_color = Color.from_hsv(0,color_val,1);

func soak():
	print("Increasing Blood")
	current_blood += 1;
	set_color();

func clear():
	current_blood = 0;
	set_color();
