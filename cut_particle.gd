extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	$Particle.modulate.a -= .15


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
