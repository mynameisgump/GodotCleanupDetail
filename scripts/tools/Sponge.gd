class_name Sponge
extends CharacterBody3D

var current_blood = 0;

func soak():
	print("Increasing Blood")
	current_blood += 1;

func _physics_process(delta):
	pass
