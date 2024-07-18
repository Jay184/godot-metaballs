extends ColorRect


# Layout as an image is as followed:
#   0      1      2      ...
# 0 color1 color2 color3
# 1 pos1   pos2   pos3

var _buffer_texture := ImageTexture.new()
var _buffer_balls := Image.new()


func _ready():
	_buffer_balls = Image.create(1, 2, false, Image.FORMAT_RGBA8)


func _process(_delta):
	var children = get_children()
	var count = len(children)
	var resolution = size # get_viewport().get_visible_rect().size
	
	_buffer_balls.resize(max(1, count), 2)
	_buffer_balls.fill(Color.TRANSPARENT)
	
	for i in count:
		var node = children[i] as Node2D
		
		var pos := Color(
			node.position.x / resolution.x,
			node.position.y / resolution.y,
			node.radius / max(resolution.x, resolution.y)
		)
		
		_buffer_balls.set_pixel(i, 0, node.color)
		_buffer_balls.set_pixel(i, 1, pos)
	
	_buffer_texture = ImageTexture.create_from_image(_buffer_balls)
	
	material.set_shader_parameter('resolution', resolution)
	material.set_shader_parameter('balls', _buffer_texture)
	material.set_shader_parameter('count', count)
