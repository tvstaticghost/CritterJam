extends Label

@export var base_font_size: int = 24
@export var reference_resolution := Vector2(1920, 1080)

func _ready():
	update_font_size()
	get_viewport().connect("size_changed", Callable(self, "update_font_size"))

func update_font_size():
	var screen_size = get_viewport().get_visible_rect().size
	var scale_factor = screen_size.y / reference_resolution.y
	var new_size = int(base_font_size * scale_factor)
	add_theme_font_size_override("font_size", new_size)
