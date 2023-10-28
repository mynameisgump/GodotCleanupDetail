class_name Blood
extends Area3D

func _ready():
	pass 

func _process(delta):
	pass

func _on_body_entered(body):
	
	if body.is_in_group("Player"):
		pass
		
	if body.is_in_group("Sponge"):
		if body.current_blood < body.max_blood:
			body.soak();
			queue_free();
			
	if body.is_in_group("Meat"):
		body.overlapping.append(self);

func _on_body_exited(body):
	if body.is_in_group("Meat"):
		body.overlapping.erase(self);
