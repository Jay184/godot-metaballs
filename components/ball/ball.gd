@tool
class_name Ball
extends Node2D


@export var radius := 20.0
@export var color := Color.BLACK


func _process(_delta):
	if Engine.is_editor_hint():
		queue_redraw()


func _draw():
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, radius, color)
