class_name Enemy
extends Node2D

var path_follow: PathFollow2D

var move_speed: float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress += move_speed * delta
	if path_follow.progress_ratio >= 0.99:
		print("player lost 1 health")
		queue_free()

func setup(new_path_follow: PathFollow2D):
	path_follow = new_path_follow
