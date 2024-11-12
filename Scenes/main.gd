extends Node

var save_path = "user://savegame.json" # %appdata%\Roaming\Godot\app_userdata\Cacti Cutter\savegame.json

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FileAccess.file_exists(save_path):
		load_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Saves the variables in save_data.gd to a save file
func save_game():
	var save_file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")
		#print(node_data)
		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)
		#print(json_string)
		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
		
		
func load_game():
	if not FileAccess.file_exists("user://savegame.json"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.json", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data

		# Firstly, we need to create the object
		var new_object = get_node(node_data["filename"])
		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename":
				continue
			new_object.set(i, node_data[i])
		new_object.startup()
