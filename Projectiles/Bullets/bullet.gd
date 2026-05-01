extends Area2D

var direction: Vector2
var speed : float = 200
var Damage : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func setup(pos: Vector2, angle: float, bullet_enum: Data.Bullet, damage: float):
	position = pos
	direction = Vector2.UP.rotated(angle)
	rotation = angle
	Damage = damage
