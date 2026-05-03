class_name Tower 
extends Node2D

var enemies: Array

@export var rotation_speed : float = 4
@export var detection_range : float = 100
@export var damage : float

@warning_ignore("unused_signal")
signal shoot(position: Vector2, direction: float, bullet_enum: Data.Bullet, damage : float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_enemy_detection_area_area_entered(area: Area2D) -> void:
	if area not in enemies:
		enemies.append(area)


func _on_enemy_detection_area_area_exited(area: Area2D) -> void:
	if area in enemies:
		enemies.erase(area)
