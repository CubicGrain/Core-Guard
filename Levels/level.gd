class_name Level
extends Node2D

var enemy_scene = preload("res://Enemies/enemy.tscn")
var bullet_scene = preload("res://Projectiles/Bullets/bullet.tscn")
var snipe_bullet_scene = preload("res://Projectiles/Bullets/snipe_bullet.tscn")
var current_enemy_spawn : Data.Enemy

var waves_active : bool = false
var current_level_waves : Dictionary
var current_wave : int
var current_enemy_num : int
@export var wave_time : float = 10

var wave_handler_on_coolown : bool = false

@onready var wave_timer = $WaveTimer
@onready var enemy_timer = $EnemyTimer
@onready var path_node = $Path2D
@onready var next_wave_button = $"PlayerCamera/Wave Control/NextWave"
@onready var wave_time_display = $"PlayerCamera/Wave Control/WaveTime"
@onready var tower_slot_tilemap = $BG/TowerSlots
@onready var tower_ui = $PlayerCamera/tower_ui

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
	for tower in $Towers.get_children():
		tower.connect('shoot', create_bullet)
	next_wave_button.connect('pressed', skip_wave_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	wave_handler(current_level_waves)
	wave_time_display.text = str(snapped(wave_timer.time_left, 0.1))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var clicked_tile = tower_slot_tilemap.local_to_map(tower_slot_tilemap.get_local_mouse_position())
			var tile_data = tower_slot_tilemap.get_cell_tile_data(clicked_tile)
			if tile_data:
				var slot_type = tile_data.get_custom_data("tower_slot")
				if slot_type != null:
					print(slot_type)
					tower_ui.visible = true
					$PlayerCamera/tower_ui/Sidebar/TowerSelect.visible = true
					
					if slot_type == "standard":
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Standard.visible = true
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Support.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/HighGround.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Trap.visible = false
					else: if slot_type == "support":
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Support.visible = true
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/HighGround.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Trap.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Standard.visible = false
					else: if slot_type == "high_ground":
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/HighGround.visible = true
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Support.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Trap.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Standard.visible = false
					else: if slot_type == "trap":
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Trap.visible = true
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Support.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/HighGround.visible = false
						$PlayerCamera/tower_ui/Sidebar/TowerSelect/Standard.visible = false
					
				
	pass

func create_bullet(pos: Vector2, angle: float, bullet_enum: Data.Bullet, damage: float):
	var bullet
	if bullet_enum == Data.Bullet.SINGLE:
		bullet = bullet_scene.instantiate()
	else: if bullet_enum == Data.Bullet.SNIPE:
		bullet = snipe_bullet_scene.instantiate()
	
	if bullet:
		bullet.setup(pos, angle, bullet_enum, damage)
		$Bullets.add_child(bullet)
	else:
		push_warning("bullet not instantiated")

func skip_wave_timer():
	if waves_active and not wave_timer.paused and wave_timer.time_left > 0:
		wave_timer.start(0.1)
		print("skipped wave")

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
			wave_timer.start(wave_time)
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
