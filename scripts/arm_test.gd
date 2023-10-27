extends Skeleton3D

@onready var blood_timer: Timer = $BloodTimer

signal spawn_blood(pos: Vector3,nor: Vector3);

var Blood = preload("res://scenes/blood.tscn");

const GRAB_FORCE: int = 20;
var linear_vel = null;
var entered_blood = false;
var overlapping = []
var max_overlapping = 1;

func _on_body_entered(body):
	pass # Replace with function body.

func _ready():
	print(":()")
	physical_bones_start_simulation()

func _process(delta):
	pass
