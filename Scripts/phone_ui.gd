extends Control

@onready var tone_1: AudioStreamPlayer = $Tone_1
@onready var tone_2: AudioStreamPlayer = $Tone_2
@onready var tone_3: AudioStreamPlayer = $Tone_3
@onready var tone_4: AudioStreamPlayer = $Tone_4
@onready var tone_5: AudioStreamPlayer = $Tone_5
@onready var tone_6: AudioStreamPlayer = $Tone_6
@onready var tone_7: AudioStreamPlayer = $Tone_7
@onready var tone_8: AudioStreamPlayer = $Tone_8
@onready var tone_9: AudioStreamPlayer = $Tone_9
@onready var tone_0: AudioStreamPlayer = $Tone_0

@onready var purple_book_audio: AudioStreamPlayer = $"../../PurpleBookAudio"
@onready var purple_book_text: MeshInstance3D = $"../../LivingRoomLevel/CritterJam_LivingRoom1/PurpleClueBook/Text"
@onready var tv_static_audio: AudioStreamPlayer3D = $"../../LivingRoomLevel/TVandSpeakers/Television/TVStaticAudio"
@onready var tv_static_mesh: MeshInstance3D = $"../../LivingRoomLevel/TVandSpeakers/Television/TVStaticImage"
@onready var call_timer: Timer = $"../../CallTimer"
@onready var call_failed_audio: AudioStreamPlayer = $"../../CallFailed"
@onready var call_failed_timer: Timer = $"../../CallFailedTimer"

@onready var phone_ring_audio: AudioStreamPlayer = $"../../PhoneRinging"
@onready var world_script = $"../.."

@onready var number_field: Label = $Panel/NumberField
@onready var number_entered: String = ""

var calling: bool = false
var can_open_phone: bool = true

func update_number_field(number):
	if len(number_entered) < 12:
		number_entered += number
		number_field.text = number_entered
		if len(number_entered) == 3 or len(number_entered) == 7:
			number_entered += "-"
			number_field.text = number_entered

func one_pressed() -> void:
	if not calling:
		tone_1.play()
		update_number_field("1")
	
func two_pressed() -> void:
	if not calling:
		tone_2.play()
		update_number_field("2")
	
func three_pressed() -> void:
	if not calling:
		tone_3.play()
		update_number_field("3")
	
func four_pressed() -> void:
	if not calling:
		tone_4.play()
		update_number_field("4")
	
func five_pressed() -> void:
	if not calling:
		tone_5.play()
		update_number_field("5")
	
func six_pressed() -> void:
	if not calling:
		tone_6.play()
		update_number_field("6")
	
func seven_pressed() -> void:
	if not calling:
		tone_7.play()
		update_number_field("7")

func eight_pressed() -> void:
	if not calling:
		tone_8.play()
		update_number_field("8")

func nine_pressed() -> void:
	if not calling:
		tone_9.play()
		update_number_field("9")

func zero_pressed() -> void:
	if not calling:
		tone_0.play()
		update_number_field("0")

func call_pressed() -> void:
	if not calling:
		try_phone_call()

func try_phone_call():
	#numbers: 555-927-1908 for purple book and 555-254-1909 for sticky note
	calling = true
	world_script.is_on_call = true
	phone_ring_audio.play()
	#timer
	call_timer.start()

func back_pressed() -> void:
	if not calling:
		number_entered = number_entered.left(number_entered.length() - 1)
		number_field.text = number_entered


func call_timeout() -> void:
	if number_entered == "555-927-1908":
		print("Turn TV ON")
		tv_static_audio.play()
		tv_static_mesh.visible = true
		number_entered = ""
		number_field.text = number_entered
		calling = false
		world_script.is_on_call = false
	
	elif number_entered == "555-254-1909":
		print("Purple Book")
		purple_book_audio.play()
		purple_book_text.visible = true
		number_entered = ""
		number_field.text = number_entered
		calling = false
		world_script.is_on_call = false
	else:
		call_failed_audio.play()
		call_failed_timer.start()

func call_failed() -> void:
	number_entered = ""
	number_field.text = number_entered
	calling = false
	world_script.is_on_call = false
