extends Camera3D

# Script to pan camera around the scene
var camera_rotation_amount: float = 0.01
var max_pitch: float = 0.22
var min_pitch: float = -0.25 

func _process(_delta: float) -> void:
	# Tilt down
	if Input.is_action_pressed("down"):
		if rotation.x + camera_rotation_amount <= max_pitch:
			rotation.x += camera_rotation_amount
			print(rotation)

	# Tilt up
	if Input.is_action_pressed("up"):
		if rotation.x - camera_rotation_amount >= min_pitch:
			rotation.x -= camera_rotation_amount
			print(rotation)
			
	# Tilt left
	if Input.is_action_pressed("left"):
		if rotation.y - camera_rotation_amount >= min_pitch:
			rotation.y -= camera_rotation_amount
			
	# Tilt right
	if Input.is_action_pressed("right"):
		if rotation.y + camera_rotation_amount <= max_pitch:
			rotation.y += camera_rotation_amount
