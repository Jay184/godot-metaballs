tool
extends Node2D


export var radius: float = 20.0
export var color: Color = Color.black


func _process(_delta):
	if Engine.editor_hint:
		update()


func _draw():
	if Engine.editor_hint:
		draw_circle(Vector2.ZERO, radius, color)
