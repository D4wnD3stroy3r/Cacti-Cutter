extends Node

@export var score = 0
var cut_particle = load("res://cut_particle.tscn")
var mouse_position_stack = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CactusTarget/ScoreBox.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		if event.relative:
			mouse_position_stack.append(get_viewport().get_mouse_position())
			if mouse_position_stack.size() > 5:
				mouse_position_stack.remove_at(0)
				#print(mouse_position_stack)

func _on_cactus_target_mouse_exited():
	score += 1
	$CactusTarget/ScoreBox.text = str(score)
	var particle_angle = mouse_position_stack[0].angle_to_point(get_viewport().get_mouse_position())
	
	var particle = cut_particle.instantiate()
	var velocity = Vector2(200,0)
	var particle_spawn_location = get_viewport().get_mouse_position()
	particle.position = particle_spawn_location
	particle.rotation = particle_angle
	particle.linear_velocity = velocity.rotated(particle_angle)
	add_child(particle)
