extends Resource
class_name SaveData

# Global score
@export var score : int = 0

# Callable function to increase score
func increase_score(value : int):
	score += value
