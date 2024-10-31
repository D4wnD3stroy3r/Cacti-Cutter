extends Node

@export var score = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CactusTarget/ScoreBox.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_cactus_target_mouse_exited():
	score += 1
	$CactusTarget/ScoreBox.text = str(score)
