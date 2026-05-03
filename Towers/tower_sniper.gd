extends Tower

var can_shoot : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_circle = CircleShape2D.new()
	new_circle.radius = detection_range
	$EnemyDetectionArea/CollisionShape2D.shape = new_circle
	$Target.target_position = Vector2(detection_range,0)
	$Turret/TurretRay.target_position = Vector2(detection_range,0)
	$ReloadTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemies.size() > 0:
		$Target.look_at(enemies[0].global_position)
	
	if $Target.rotation - $Turret.rotation > 0:
		$Turret.rotate(rotation_speed * delta)
	if $Target.rotation - $Turret.rotation < 0:
		$Turret.rotate(-rotation_speed * delta)
	
	if not $Turret/TurretRay.is_colliding():
		$ChargeTimer.stop()
		
	
	if enemies and $Turret/TurretRay.is_colliding():
		if $ChargeTimer.is_stopped() or $ChargeTimer.paused:
			$ChargeTimer.start()
			
	



func _on_reload_timer_timeout() -> void:
	
	can_shoot = true



func _on_charge_timer_timeout() -> void:
	if enemies and $Turret/TurretRay.is_colliding() and can_shoot:
		var direction = Vector2.RIGHT.rotated($Turret.rotation).normalized()
		shoot.emit(position + direction * 40, $Turret.rotation + PI/2, Data.Bullet.SNIPE, damage)
		can_shoot = false
		$ReloadTimer.start()
	
