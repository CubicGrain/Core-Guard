extends Tower


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if enemies.size() > 0:
		$Turret.look_at(enemies[0].global_position)
		$Turret.rotation += PI/2


func _on_reload_timer_timeout() -> void:
	if enemies:
		var direction = Vector2.UP.rotated($Turret.rotation).normalized()
		shoot.emit(position + direction * 40, $Turret.rotation, Data.Bullet.SINGLE)
