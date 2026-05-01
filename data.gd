class_name Data
extends Node

enum Tower {BASIC, BLAST, SPLASH}
enum Bullet {SINGLE, FIRE, EXPLOSION}
enum Enemy {BASIC, FAST, STRONG, AIR, BOSS}

const TOWER_DATA = {}
const UPGRADE_DATA = {}
const ENEMY_WAVES = {
	'test level': {
		## waves
		1: {
			## enemies + time to appear
			1: {'enemy': Enemy.BASIC, 'time': 1},
			2: {'enemy': Enemy.BASIC, 'time': 1},
			3: {'enemy': Enemy.BASIC, 'time': 1},
			4: {'enemy': Enemy.BASIC, 'time': 1},
			5: {'enemy': Enemy.BASIC, 'time': 1},
			
		},
		2: {
			## enemies + time to appear
			1: {'enemy': Enemy.BASIC, 'time': 1},
			2: {'enemy': Enemy.BASIC, 'time': 1},
			3: {'enemy': Enemy.BASIC, 'time': 1},
			4: {'enemy': Enemy.BASIC, 'time': 3},
			5: {'enemy': Enemy.BASIC, 'time': 1},
			6: {'enemy': Enemy.BASIC, 'time': 1},
			7: {'enemy': Enemy.BASIC, 'time': 3},
			8: {'enemy': Enemy.BASIC, 'time': 1},
			9: {'enemy': Enemy.BASIC, 'time': 1},
		},
		3: {
			
		},
	},
}
const ENEMY_DATA = {
	Enemy.BASIC: {'health': 10, 'speed': 20, 'scene': "res://Enemies/enemy.tscn"},
}
