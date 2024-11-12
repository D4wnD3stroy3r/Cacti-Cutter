extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressed() -> void:
	if $/root/main/Score.score - $"..".cost >= 0 :
		$/root/main/Score.score -= $"..".cost
		$"..".cost *= $"..".cost_multi
		$"..".level += 1
		$"..".update_button()
	else:
		OS.alert("Not enough money","Alert!") # Needs to be replaced with an in-game popup
