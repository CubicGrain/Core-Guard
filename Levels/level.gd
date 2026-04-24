class_name Level
extends Node2D

var enemy_scene = preload("res://Enemies/enemy.tscn")
var bullet_scene = preload("res://Projectiles/Bullets/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var path_follow = PathFollow2D.new()
	var enemy = enemy_scene.instantiate()
	enemy.setup(path_follow)
	path_follow.add_child(enemy)
	$Path2D.add_child(path_follow)
	$Towers/TowerBasic.connect('shoot', create_bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func create_bullet(pos: Vector2, angle: float, bullet_enum: Data.Bullet):
	var bullet = bullet_scene.instantiate()
	bullet.setup(pos, angle, bullet_enum)
	$Bullets.add_child(bullet)
