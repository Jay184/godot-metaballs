extends Node2D


const ball = preload('res://src/components/ball/ball.tscn')

onready var metaball = $CanvasLayer/Metaball


func _ready():
	randomize()
	metaball.add_child(rand_ball())
	
	
func _process(_delta):
	var last_ball = metaball.get_child(metaball.get_child_count() - 1)
	var mouse_position = get_viewport().get_mouse_position()
	last_ball.position = mouse_position
	
	
func _input(event):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		
		if event.pressed and mouse_event.button_index == BUTTON_LEFT:
			metaball.add_child(rand_ball())
			
			
func rand_ball() -> Node2D:
	var b = ball.instance()
	b.radius = rand_range(10.0, 50.0)
	b.color = Color(randf(), randf(), randf())
	return b
