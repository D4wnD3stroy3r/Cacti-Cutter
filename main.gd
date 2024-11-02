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

# Fills the mouse_position_stack array with the last 5 points the mouse has traveled
func _input(event):
	if event is InputEventMouseMotion:
		if event.relative:
			mouse_position_stack.append(get_viewport().get_mouse_position())
			if mouse_position_stack.size() > 5:
				mouse_position_stack.remove_at(0)
				#print(mouse_position_stack)

func _on_cactus_target_mouse_exited():
	# Add score and update score in ScoreBox
	score += 1
	$CactusTarget/ScoreBox.text = str(score)
	
	# Create a new instance of the cut_particle scene
	var particle = cut_particle.instantiate()
	
	# Set the spawn position of the particle to the mouse position when the mouse exists the collision box
	var mouse_position_on_exit = get_viewport().get_mouse_position()
	particle.position = mouse_position_on_exit
	
	# Set the rotation of the spawned particle to the angle of the mouse when it exists the collision box
	var particle_angle = mouse_position_stack[0].angle_to_point(mouse_position_on_exit)
	particle.rotation = particle_angle
	
	# Set the velocity of the particle
	var velocity = Vector2(200,0)
	particle.linear_velocity = velocity.rotated(particle_angle)
	
	# Spawn the particle
	add_child(particle)
