class_name Blood
extends Area3D

func _ready():
	pass 

func _process(delta):
	pass


func _on_body_entered(body):
	queue_free()
	pass # Replace with function body.
