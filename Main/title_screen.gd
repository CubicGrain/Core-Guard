class_name TitleScreen
extends Control

@onready var title = $Title
@onready var title_timer = $Title/Timer
var title_animation_frame_time = 2.5
var title_base_size = 0

@onready var start_button = $StartButton
@onready var start_button_timer = $StartButton/Timer
var start_button_animation_frame_time = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_base_size = title.scale
	
	title.scale = title_base_size * 1.5
	title.rotation = deg_to_rad(-5.0)
	title_timer.wait_time = title_animation_frame_time
	
	start_button.rotation = deg_to_rad(-5.0)
	start_button_timer.wait_time = start_button_animation_frame_time
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass

var start_button_animation_loop : int = 0 

func _on_start_button_timer_timeout() -> void:
	if start_button_animation_loop == 0:
		var start_button_tween = get_tree().create_tween()
		start_button_tween.tween_property(start_button, "rotation",deg_to_rad(5.0),start_button_animation_frame_time).set_trans(Tween.TRANS_SINE)
	
	if start_button_animation_loop == 1:
		var start_button_tween = get_tree().create_tween()
		start_button_tween.tween_property(start_button, "rotation",deg_to_rad(-5.0),start_button_animation_frame_time).set_trans(Tween.TRANS_SINE)
	
	start_button_animation_loop += 1
	
	if start_button_animation_loop >= 2:
		start_button_animation_loop = 0
	
	pass # Replace with function body.

var title_animation_loop : int = 0

func _on_title_timer_timeout() -> void:
	if title_animation_loop == 0:
		var title_tween = get_tree().create_tween()
		title_tween.tween_property(title, "rotation",deg_to_rad(5.0),title_animation_frame_time * 2).set_trans(Tween.TRANS_SINE)
		var title_size_tween = get_tree().create_tween()
		title_size_tween.tween_property(title, "scale", title_base_size * 1,title_animation_frame_time).set_trans(Tween.TRANS_SINE)
	
	if title_animation_loop == 1:
		var title_size_tween = get_tree().create_tween()
		title_size_tween.tween_property(title, "scale", title_base_size * 1.5,title_animation_frame_time).set_trans(Tween.TRANS_SINE)
	
	
	if title_animation_loop == 2:
		var title_tween = get_tree().create_tween()
		title_tween.tween_property(title, "rotation",deg_to_rad(-5.0),title_animation_frame_time * 2).set_trans(Tween.TRANS_SINE)
		var title_size_tween = get_tree().create_tween()
		title_size_tween.tween_property(title, "scale", title_base_size * 1,title_animation_frame_time).set_trans(Tween.TRANS_SINE)
	
	if title_animation_loop == 3:
		var title_size_tween = get_tree().create_tween()
		title_size_tween.tween_property(title, "scale", title_base_size * 1.5,title_animation_frame_time).set_trans(Tween.TRANS_SINE)
	
	
	title_animation_loop += 1
	
	if title_animation_loop >= 4:
		title_animation_loop = 0
	
	
	pass # Replace with function body.
