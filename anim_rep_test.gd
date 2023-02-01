extends Control

@onready var sp = $sp
@onready var anim = $AnimationPlayer
@onready var anim_name = $anim_name
@onready var buf_name = $buf_name

var current_anim : String
var anim_buffer : String
var anim_active := false

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		if !anim_active:
			change_anim("going_up")
		else:
			buffer_anim("going_up")
	if Input.is_action_just_pressed("ui_left"):
		if !anim_active:
			change_anim("going_left")
		else:
			buffer_anim("going_left")

func change_anim(nm):
	current_anim = nm
	anim_name.text = nm
	play_anim(nm)

func play_anim(nm):
	anim.play(nm)
	anim_active = true
	await anim.animation_finished
#	anim_name.text = ""
	if anim_buffer != "":
		change_anim(anim_buffer)
		anim_buffer = ""
		buf_name.text = ""
	else:
		anim_active = false
		if nm == "idle":
			return
		change_anim("idle")
	
func buffer_anim(nm):
	anim_buffer = nm
	buf_name.text = nm
