class_name Data
extends Node

enum Tower {BASIC, BLAST, SPLASH}
enum Bullet {SINGLE, FIRE, EXPLOSION}
enum Enemy {BASIC, FAST, STRONG, AIR, BOSS}

const TOWER_DATA = {}
const UPGRADE_DATA = {}
const ENEMY_WAVES = {}
const ENEY_DATA = {
	Enemy.BASIC: {'health': 10, 'speed': 20}
}
