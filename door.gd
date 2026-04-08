extends Node3D

var player_nearby = false


func _input(_event):
	if player_nearby and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://House.tscn")  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_area_3d_body_entered(_body: Node3D) -> void:
	player_nearby = true # Replace with function body.


func _on_area_3d_body_exited(_body: Node3D) -> void:
	player_nearby = false # Replace with function body.
