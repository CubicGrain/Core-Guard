extends Area2D

var direction: Vector2
var speed : float = 1000
var Damage : float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Lifetime.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func setup(pos: Vector2, angle: float, bullet_enum: Data.Bullet, damage: float):
	position = pos
	direction = Vector2.UP.rotated(angle)
	rotation = angle
	Damage = damage


func _on_lifetime_timeout() -> void:
	queue_free()
