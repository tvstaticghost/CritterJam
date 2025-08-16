extends Camera3D

@onready var purple_book_text = $"../LivingRoomLevel/CritterJam_LivingRoom1/Cushion_001/PurpleClueBook/Text"

var camera_rotation_amount: float = 0.2
var camera_zoom_amount: float = 0.5

var starting_camera_x: float
var starting_camera_y: float
var max_fov: float = 80.0
var min_fov: float = 25.0
#30.0 to 80.0 FOV

var is_camera_moving: bool = false
var is_phone_active: bool = false

func _ready() -> void:
	starting_camera_x = rotation_degrees.x
	starting_camera_y = rotation_degrees.y
	print(rotation_degrees.x)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if !is_phone_active:
			shoot_ray()
	
func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = space.intersect_ray(ray_query)
	
	if !raycast_result.is_empty():
		print(str(raycast_result.collider.name))
		if raycast_result.collider.name == "Purple Book":
			purple_book_text.visible = true
		#Change this functionality to display in UI

func _process(_delta: float) -> void:
	is_camera_moving = false
	
	# Look down
	if Input.is_action_pressed("down"):
		if !is_phone_active:
			if rotation_degrees.x - camera_rotation_amount >= starting_camera_x - 15.0:
				rotation_degrees.x -= camera_rotation_amount
				is_camera_moving = true

	# Look up
	if Input.is_action_pressed("up"):
		if !is_phone_active:
			if rotation_degrees.x + camera_rotation_amount <= starting_camera_x + 15.0:
				rotation_degrees.x += camera_rotation_amount
				is_camera_moving = true
			
	# Turn left
	if Input.is_action_pressed("left"):
		if !is_phone_active:
			if rotation_degrees.y + camera_rotation_amount <= starting_camera_y + 15.0:
				rotation_degrees.y += camera_rotation_amount
				is_camera_moving = true
			
	# Turn right
	if Input.is_action_pressed("right"):
		if !is_phone_active:
			if rotation_degrees.y - camera_rotation_amount >= starting_camera_y - 15.0:
				rotation_degrees.y -= camera_rotation_amount
				is_camera_moving = true
			
	if Input.is_action_pressed("zoom_in"):
		if !is_phone_active:
			if fov - camera_zoom_amount >= min_fov:
				fov -= camera_zoom_amount
	
	if Input.is_action_pressed("zoom_out"):
		if !is_phone_active:
			if fov + camera_zoom_amount <= max_fov:
				fov += camera_zoom_amount
		
			
	if not Input.is_anything_pressed():
		is_camera_moving = false
		
	if is_camera_moving:
		if not $AudioStreamPlayer.playing:
			play_camera_movement_sound()
	else:
		if $AudioStreamPlayer.playing:
			stop_camera_movement_sound()

func play_camera_movement_sound():
	$AudioStreamPlayer.play()
	
func stop_camera_movement_sound():
	$AudioStreamPlayer.stop()
