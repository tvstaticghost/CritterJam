extends Node3D

@onready var kitchen_cam_1: Camera3D = $KitchenCam1
@onready var kitchen_cam_2: Camera3D = $KitchenCam2
@onready var livingroom_cam_1: Camera3D = $LivingRoomCam1
@onready var livingroom_cam_2: Camera3D = $LivingRoomCam2
@onready var camera_switch_player: AudioStreamPlayer = $CameraSwitchPlayer

@onready var phone_ui: Control = $CanvasLayer/PhoneUI

@onready var tv_static_mesh: MeshInstance3D = $LivingRoomLevel/TVandSpeakers/Television/TVStaticImage
@onready var blur_overlay: ColorRect = $CanvasLayer/Control/BlurOverlay

@onready var guess_button: Button = $CanvasLayer/Control/GuessButton
@onready var object_selection_menu: Control = $CanvasLayer/ObjectSelectionMenu
@onready var control: Control = $CanvasLayer/Control

@onready var animation_player: AnimationPlayer = $CanvasLayer/FadeToBlack/AnimationPlayer
@onready var win_timer: Timer = $WinTimer


var current_camera: Camera3D
var is_phone_active: bool = false
var is_on_call: bool = false
var can_open_phone: bool = true
var camera_list
var did_win: bool = false

var losing_scene = preload("res://Scenes/losing_scene.tscn")


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
	if !is_on_call:
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
		if can_open_phone:
			toggle_phone()


func guess_object_button_pressed() -> void:
	print("pressed button")
	if !is_on_call or !is_phone_active:
		object_selection_menu.visible = true
		control.visible = false
		can_open_phone = false

func check_game_won(object_text):
	if object_text == "Candle":
		did_win = true
	animation_player.play("fade_to_black")
	win_timer.start()


func win_timer_done() -> void:
	if !did_win:
		get_tree().change_scene_to_packed(losing_scene)
