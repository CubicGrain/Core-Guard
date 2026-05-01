extends Camera2D

var drag: bool
@export var acceleration: float = 0.8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 2 and event.pressed:
		drag = true
	if event is InputEventMouseButton and event.button_index == 2 and not event.pressed:
		drag = false
	if event is InputEventMouseMotion:
		if drag:
			position -= event.relative * acceleration
