extends Node3D

@onready var kitchen_cam_1: Camera3D = $KitchenCam1
@onready var kitchen_cam_2: Camera3D = $KitchenCam2
@onready var livingroom_cam_1: Camera3D = $LivingRoomCam1
@onready var livingroom_cam_2: Camera3D = $LivingRoomCam2
@onready var camera_switch_player: AudioStreamPlayer = $CameraSwitchPlayer

@onready var phone_ui: Control = $CanvasLayer/PhoneUI

@onready var tv_static_mesh: MeshInstance3D = $LivingRoomLevel/TVandSpeakers/Television/TVStaticImage
@onready var blur_overlay: ColorRect = $CanvasLayer/Control/BlurOverlay

var current_camera: Camera3D
var is_phone_active: bool = false
var camera_list


# Called when the node enters the scene tree for the first time.
func _ready():
	livingroom_cam_1.make_current()
	current_camera = livingroom_cam_1
	
	tv_static_mesh.visible = false
	
	camera_list = [kitchen_cam_1, kitchen_cam_2, livingroom_cam_1, livingroom_cam_2]

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
	
	if phone_ui.visible:
		blur_overlay.visible = true
		is_phone_active = true
		for camera in camera_list:
			camera.is_phone_active = true
	else:
		blur_overlay.visible = false
		is_phone_active = false
		for camera in camera_list:
			camera.is_phone_active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("switch_camera"):
		if !is_phone_active:
			switch_cameras()
	
	if Input.is_action_just_pressed("toggle_phone"):
		toggle_phone()
