class_name Level
extends Node2D

var enemy_scene = preload("res://Enemies/enemy.tscn")
var bullet_scene = preload("res://Projectiles/Bullets/bullet.tscn")
var current_enemy_spawn : Data.Enemy

var waves_active : bool = false
var current_level_waves : Dictionary
var current_wave : int
var current_enemy_num : int

var wave_handler_on_coolown : bool = false

@onready var wave_timer = $WaveTimer
@onready var enemy_timer = $EnemyTimer
@onready var path_node = $Path2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
##	var path_follow = PathFollow2D.new()
##	current_enemy_spawn = Data.Enemy.BASIC
##	enemy_scene = load(Data.ENEMY_DATA.get(current_enemy_spawn).get('scene'))
##	var enemy = enemy_scene.instantiate()
##	enemy.setup(path_follow, current_enemy_spawn)
##	path_follow.add_child(enemy)
##	$Path2D.add_child(path_follow)
	start_waves(Data.ENEMY_WAVES.get('test level'))
	$Towers/TowerBasic.connect('shoot', create_bullet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	wave_handler(current_level_waves)
	

func create_bullet(pos: Vector2, angle: float, bullet_enum: Data.Bullet, damage: float):
	var bullet = bullet_scene.instantiate()
	bullet.setup(pos, angle, bullet_enum, damage)
	$Bullets.add_child(bullet)

func start_waves(level_waves: Dictionary):
	current_level_waves = level_waves
	current_wave = 0
	current_enemy_num = 0
	waves_active = true
	print("Level started")

func wave_handler(level_waves: Dictionary):
	if path_node and level_waves:
		if waves_active and not wave_handler_on_coolown and not wave_timer.time_left > 0 and current_wave <= level_waves.size():
			wave_handler_on_coolown = true
			wave_timer.start()
			## FIGURE OUT HOW TO PAUSE WAVES WHILE ENEMIES ARE ALIVE
			print("test 2")
		if waves_active and current_wave > level_waves.size():
			waves_active = false
			print("waves finished")
	else:
		push_warning("Wave Handler: An error has occurred")

func _on_wave_timer_timeout() -> void:
	current_wave += 1
	print(str("New wave: " , current_wave))
	current_enemy_num = 0
	if current_wave < current_level_waves.size():
		enemy_timer.wait_time = current_level_waves.get(current_wave).get(1).get('time')
		enemy_timer.start()
	


func _on_enemy_timer_timeout() -> void:
	current_enemy_num += 1
	var wave = current_level_waves.get(current_wave)
	if current_wave <= current_level_waves.size() and current_enemy_num <= wave.size():
		current_enemy_spawn = wave.get(current_enemy_num).get('enemy')
		if current_enemy_num <= wave.size() - 1:
			enemy_timer.wait_time = wave.get(current_enemy_num+1).get('time')
			enemy_timer.start()
		spawn_enemy(current_enemy_spawn)
	if current_enemy_num == wave.size():
		wave_handler_on_coolown = false
	

func spawn_enemy(enemy: Data.Enemy):
	var path_follow = PathFollow2D.new()
	enemy_scene = load(Data.ENEMY_DATA.get(enemy).get('scene'))
	var new_enemy = enemy_scene.instantiate()
	new_enemy.setup(path_follow, enemy)
	path_follow.add_child(new_enemy)
	path_node.add_child(path_follow)


func _on_wave_handler_cooldown_timeout() -> void:
	wave_handler_on_coolown = false
