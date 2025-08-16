extends Node3D

@onready var kitchen_cam_1: Camera3D = $KitchenCam1
@onready var kitchen_cam_2: Camera3D = $KitchenCam2
@onready var livingroom_cam_1: Camera3D = $LivingRoomCam1
@onready var livingroom_cam_2: Camera3D = $LivingRoomCam2
@onready var camera_switch_player: AudioStreamPlayer = $CameraSwitchPlayer

@onready var phone_ui: Control = $CanvasLayer/PhoneUI

@onready var tv_static_mesh: MeshInstance3D = $LivingRoomLevel/TVandSpeakers/Television/TVStaticImage

var current_camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	livingroom_cam_1.make_current()
	current_camera = livingroom_cam_1
	
	tv_static_mesh.visible = false

func switch_cameras():
	camera_switch_player.play()
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
	
func toggle_phone():
	phone_ui.visible = !phone_ui.visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("switch_camera"):
		switch_cameras()
	
	if Input.is_action_just_pressed("toggle_phone"):
		toggle_phone()
