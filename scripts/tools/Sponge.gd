class_name Sponge
extends CharacterBody3D

signal spawn_blood(pos: Vector3,nor: Vector3);

@onready var sponge_mesh = $SpongeMesh;
@onready var sponge_raycast = $SpongeCast;
@onready var sponge_animation = $AnimationPlayer;

var current_blood = 0.0;
var max_blood = 10.0;
var blood_collision = false;

func attack_animation():
	sponge_animation.play("sponge_attack");
	if current_blood >= max_blood:
		blood_collision = true;
	

func check_sponge_cast():
	if sponge_raycast.is_colliding():
		var pos = sponge_raycast.get_collision_point();
		var nor = sponge_raycast.get_collision_normal();
		spawn_blood.emit(pos,nor);
		blood_collision = false;
			
			
func set_color():
	var color_val = (current_blood/max_blood);
	var material: StandardMaterial3D  = sponge_mesh.get_surface_override_material(0);
	material.albedo_color = Color.from_hsv(0,color_val,1);

func soak():
	current_blood += 1;
	set_color();

func clear():
	current_blood = 0;
	set_color();

func _process(delta):
	if current_blood >= max_blood and blood_collision:
		check_sponge_cast();
