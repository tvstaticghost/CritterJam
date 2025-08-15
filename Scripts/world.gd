extends Node3D

@onready var kitchen_cam_1: Camera3D = $KitchenCam1
@onready var kitchen_cam_2: Camera3D = $KitchenCam2
@onready var livingroom_cam_1: Camera3D = $LivingRoomCam1
@onready var livingroom_cam_2: Camera3D = $LivingRoomCam2

var current_camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	livingroom_cam_1.make_current()
	current_camera = livingroom_cam_1

func switch_cameras():
	#Add a camera switch sound effect right here
	match current_camera:
		livingroom_cam_1:
			livingroom_cam_2.make_current()
			current_camera = livingroom_cam_2
		livingroom_cam_2:
			kitchen_cam_1.make_current()
			current_camera = kitchen_cam_1
		kitchen_cam_1:
			kitchen_cam_2.make_current()
			current_camera = kitchen_cam_2
		kitchen_cam_2:
			livingroom_cam_1.make_current()
			current_camera = livingroom_cam_1
	print(current_camera)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("switch_camera"):
		switch_cameras()
