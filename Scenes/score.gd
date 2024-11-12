extends Node

@export var score := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".."/CactusTarget/ScoreBox.text = "%.2f" % score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$".."/CactusTarget/ScoreBox.text = "%.2f" % score

func change_score(value : float):
	score += value

func save():
	var save_dict = {
		"filename" : "Score",
		"score" : score,}
	return save_dict

func startup():
	$".."/CactusTarget/ScoreBox.text = "%.2f" % score

func passive_income():
	var passive_income_nodes = get_tree().get_nodes_in_group("passive_income")
	var income : float = 0
	for node in passive_income_nodes:
		if !node.has_method("income"):
			push_error("income node '%s' is missing an income() function, skipped" % node.name)
			continue
		var node_income = node.call("income")
		income += node_income
	change_score(income)
		
