# Your original node modified to use the anger manager
extends Node2D

func _ready() -> void:
	# Connect to the anger manager signals if needed
	AngerManager.connect("anger_changed", _on_anger_changed)

func lower_anger(amount: int) -> void:
	AngerManager.modify_anger(-amount)

func _on_instakill_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Opening/opening.tscn")

func _on_win_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if AngerManager.students_killed == 0:
			call_deferred("_change_scene_deferred", "res://Opening/victory.tscn")
		else:
			call_deferred("_change_scene_deferred", "res://Opening/opening.tscn")

func _change_scene_deferred(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)

func _on_anger_changed(new_value: int) -> void:
	# Handle any local updates needed when anger changes
	pass
