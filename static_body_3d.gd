extends StaticBody3D

var player_nearby = false
var selected_option = 0
var dialogue_completed = false

@export var dialogue_panel : Panel
@export var dialogue_text : Label
@export var option_a : Button
@export var option_b : Button

func _input(_event):
	if player_nearby and not Global.dialogue_open and not Global.awaiting_continue and Input.is_action_just_pressed("interact"):
		dialogue_panel.visible = true
		if dialogue_completed:
			dialogue_text.text =  "I pray to God for your safety."
			Global.awaiting_continue = true
		else:
			Global.dialogue_open = true
			option_a.visible = true
			option_b.visible = true
			option_a.grab_focus()
			dialogue_text.text = "I need you to procure something special for me."
			option_a.text = "Yes."
			option_b.text = "No."
	if Global.awaiting_continue and Input.is_action_just_pressed("ui_accept"):
		dialogue_panel.visible = false
		Global.awaiting_continue = false
		get_viewport().set_input_as_handled()
	if Global.dialogue_open:
		if Input.is_action_just_pressed("ui_up"):
			selected_option = 0
			option_a.grab_focus()
		if Input.is_action_just_pressed("ui_down"):
			selected_option = 1
			option_b.grab_focus()
		if Input.is_action_just_pressed("ui_accept"):
			if selected_option == 0:
				_on_option_a_pressed()
			else:
				_on_option_b_pressed()
			get_viewport().set_input_as_handled()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	option_a.pressed.connect(_on_option_a_pressed)
	option_b.pressed.connect(_on_option_b_pressed) 

func _on_option_a_pressed() -> void: 
	dialogue_text.text = "Excellent."
	option_a.visible = false
	option_b.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.dialogue_open = false
	Global.awaiting_continue = true
	dialogue_completed = true
	
func _on_option_b_pressed() -> void:
	dialogue_text.text = "I'm here if you change your mind."
	option_a.visible = false
	option_b.visible = false
	Global.dialogue_open = false
	Global.awaiting_continue = true
	dialogue_completed = true

func _on_area_3d_body_entered(_body: Node3D) -> void:
	player_nearby = true # Replace with function body.


func _on_area_3d_body_exited(_body: Node3D) -> void:
	player_nearby = false # Replace with function body.
