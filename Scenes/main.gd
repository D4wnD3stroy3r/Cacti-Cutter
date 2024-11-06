extends Node

var cut_particle = load("res://Scenes/cut_particle.tscn")
var mouse_position_stack : Array
var mouse_velocity : Vector2
var saveData = SaveData.new()
var save_file = "user://save.tres" # %appdata%\Roaming\Godot\app_userdata\Cacti Cutter\save.tres

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initiate ScoreBox value
	$CactusTarget/ScoreBox.text = str(saveData.score)
	if FileAccess.file_exists(save_file):
		load_game()
	$SaveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Update ScoreBox value every frame
	$CactusTarget/ScoreBox.text = str(saveData.score)


# Fills the mouse_position_stack array with the last 5 points the mouse has traveled
func _input(event):
	if event is InputEventMouseMotion:
		if event.relative:
			mouse_position_stack.append(get_viewport().get_mouse_position())
			if mouse_position_stack.size() > 5:
				mouse_position_stack.remove_at(0)



func _on_cactus_target_mouse_exited():
	# Add score
	saveData.increase_score(1)
	
	# Create a new instance of the cut_particle scene
	var particle = cut_particle.instantiate()
	
	# Set the spawn position of the particle to the center of the sprite
	particle.position = $CactusTarget/Sprite2D.position
	
	# Set the speed and direction of the particle
	var speed = 600
	var direction = Vector2(mouse_position_stack[0].direction_to(mouse_position_stack[4]))
	particle.linear_velocity = direction * speed * randf_range(.5, 1.5)
	
	# Spawn the particle
	add_child(particle)
	
	# Change cactus_target sprite2d
	$CactusTarget/Sprite2D.texture = load("res://Sprites/Cactus0%s.svg" % str(randi_range(1, 5)))




# Saves the variables in save_data.gd to a save file
func save_game():
	ResourceSaver.save(saveData, save_file)

# Loads the variables from a save file to save_data.gd
func load_game():
	saveData = ResourceLoader.load(save_file)


# Save the game every 30 seconds
func _on_save_timer_timeout() -> void:
	save_game()


# Save the game just before closing
func _on_tree_exiting() -> void:
	save_game()
