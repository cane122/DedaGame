extends Node2D

var anger : int = 5;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func lower_anger(amount : int):
	anger -= amount

func _on_win_area_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://Opening/opening.tscn")


func _on_instakill_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Opening/opening.tscn")
