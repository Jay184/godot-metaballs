extends ColorRect


var _buffer_texture = ImageTexture.new()
var _buffer_balls = Image.new()


func _ready():
	_buffer_balls.create(1, 2, false, Image.FORMAT_RGBA8)


func _process(_delta):
	var children = get_children()
	var size = len(children)
	var resolution = get_viewport().get_visible_rect().size
	
	_buffer_balls.resize(max(1, size), 2)
	_buffer_balls.fill(Color.transparent)
	_buffer_balls.lock()
	
	for i in size:
		var node = children[i]
		var pos = Color(
			node.position.x / resolution.x,
			node.position.y / resolution.y,
			node.radius / resolution.x
		)
		_buffer_balls.set_pixel(i, 0, node.color)
		_buffer_balls.set_pixel(i, 1, pos)
	
	_buffer_balls.unlock()
	_buffer_texture.create_from_image(_buffer_balls, 0)
	
	material.set_shader_param('resolution', resolution)
	material.set_shader_param('balls', _buffer_texture)
	material.set_shader_param('count', size)
