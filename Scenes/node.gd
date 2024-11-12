extends Node

@export var cps : float = 2
@export var level : int = 0
@export var cost_multi : float = 1.2
@export var cost : float = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func save():
	var save_dict = {
		"filename" : "Upgrades/Upgrade2",
		"level" : level,
		"cost" : cost}
	return save_dict

func update_button():
	$BuyUpgrade2.text = "Upgrade2
	Level %d
	Cost: %.2f" % [level, cost]

func startup():
	update_button()

func income():
	var passive_income : float = cps * level
	return passive_income
