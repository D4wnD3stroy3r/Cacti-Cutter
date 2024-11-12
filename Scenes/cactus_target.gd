extends Area2D

var mouse_position_stack : Array
var mouse_velocity : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Fills the mouse_position_stack array with the last 5 points the mouse has traveled
func _input(event):
	if event is InputEventMouseMotion:
		if event.relative:
			mouse_position_stack.append(get_viewport().get_mouse_position())
			if mouse_position_stack.size() > 5:
				mouse_position_stack.remove_at(0)



func _on_mouse_exited() -> void:
	# Add score
	$"../Score".change_score(1)
	
	# Create a new instance of the cut_particle scene
	var cut_particle = load("res://Scenes/cut_particle.tscn")
	var particle = cut_particle.instantiate()
	
	# Set the spawn position of the particle to the center of the sprite
	particle.position = $Sprite2D.position
	
	# Set the speed and direction of the particle
	var speed = 600
	var direction = Vector2(mouse_position_stack[0].direction_to(mouse_position_stack[4]))
	particle.linear_velocity = direction * speed * randf_range(.5, 1.5)
	
	# Spawn the particle
	add_child(particle)
	
	# Change cactus_target sprite2d
	$Sprite2D.texture = load("res://Sprites/Cactus0%s.svg" % str(randi_range(1, 5)))
