class_name Enemy
extends Area2D

var path_follow: PathFollow2D

var max_health: float = 10
var health: float = max_health
var move_speed: float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress += move_speed * delta
		if health <= 0:
			print("enemy killed")
			queue_free()
		if path_follow.progress_ratio >= 0.99:
			print("player lost 1 health")
			queue_free()
	else:
		push_warning("enemy is missing path to follow")
	
	 

func setup(new_path_follow: PathFollow2D, enemy_enum: Data.Enemy):
	move_speed = Data.ENEMY_DATA.get(enemy_enum).get('speed')
	max_health = Data.ENEMY_DATA.get(enemy_enum).get('health')
	health = max_health
	path_follow = new_path_follow

func _on_area_entered(bullet: Area2D) -> void:
	health -= bullet.Damage
	bullet.queue_free()
	
