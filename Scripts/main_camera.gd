extends Camera3D

# Script to pan camera around the scene
var camera_rotation_amount: float = 0.002
var max_pitch: float = 0.22
var min_pitch: float = -0.25 

var is_camera_moving: bool = false

func play_camera_movement_sound():
	$AudioStreamPlayer3D.play()
	
func stop_camera_movement_sound():
	$AudioStreamPlayer3D.stop()

func _process(_delta: float) -> void:
	is_camera_moving = false
	# Tilt down
	if Input.is_action_pressed("down"):
		if rotation.x + camera_rotation_amount <= max_pitch:
			rotation.x += camera_rotation_amount
			is_camera_moving = true

	# Tilt up
	if Input.is_action_pressed("up"):
		if rotation.x - camera_rotation_amount >= min_pitch:
			rotation.x -= camera_rotation_amount
			is_camera_moving = true
			
	# Tilt left
	if Input.is_action_pressed("left"):
		if rotation.y - camera_rotation_amount >= min_pitch:
			rotation.y -= camera_rotation_amount
			is_camera_moving = true
			
	# Tilt right
	if Input.is_action_pressed("right"):
		if rotation.y + camera_rotation_amount <= max_pitch:
			rotation.y += camera_rotation_amount
			is_camera_moving = true
			
	if not Input.is_anything_pressed():
		is_camera_moving = false
		
	print(is_camera_moving)
		
	if is_camera_moving:
		if not $AudioStreamPlayer3D.playing:
			play_camera_movement_sound()
	else:
		if $AudioStreamPlayer3D.playing:
			stop_camera_movement_sound()
