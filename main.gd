extends Node

var cut_particle = load("res://cut_particle.tscn")
var mouse_position_stack = []
var saveData = SaveData.new()
var save_file = "user://save.tres"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initiate ScoreBox value
	$CactusTarget/ScoreBox.text = str(0)
	if FileAccess.file_exists(save_file):
		load_game()


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
				#print(mouse_position_stack)



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
	particle.linear_velocity = direction * speed
	
	# Spawn the particle
	add_child(particle)


func _on_save_game_pressed() -> void:
	save_game()

func save_game():
	ResourceSaver.save(saveData, save_file)

func load_game():
	saveData = ResourceLoader.load(save_file)
