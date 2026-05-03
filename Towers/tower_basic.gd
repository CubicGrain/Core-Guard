extends Tower



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_circle = CircleShape2D.new()
	new_circle.radius = detection_range
	$EnemyDetectionArea/CollisionShape2D.shape = new_circle
	$Target.target_position = Vector2(0,-detection_range)
	$Turret/TurretRay.target_position = Vector2(0,-detection_range)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemies.size() > 0:
		$Target.look_at(enemies[0].global_position)
		$Target.rotation += PI/2
	
	if $Target.rotation - $Turret.rotation > 0:
		$Turret.rotate(rotation_speed * delta)
	if $Target.rotation - $Turret.rotation < 0:
		$Turret.rotate(-rotation_speed * delta)


func _on_reload_timer_timeout() -> void:
	if enemies and $Turret/TurretRay.is_colliding():
		var direction = Vector2.UP.rotated($Turret.rotation).normalized()
		shoot.emit(position + direction * 40, $Turret.rotation, Data.Bullet.SINGLE, damage)
