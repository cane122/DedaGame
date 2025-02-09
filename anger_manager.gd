# anger_manager.gd
extends Node

signal anger_changed(new_value: int)
signal students_killed_changed(new_value: int)

var anger: int = 30
var students_killed: int = 0

func _ready() -> void:
	# Initialize with default values when game starts
	anger = 30
	students_killed = 0

func modify_anger(amount: int) -> void:
	anger = clamp(anger - amount, 0, 30)

func check_anger_effects() -> String:
	var state = "min"
	if anger >= 30:
		state = "max"
	elif anger >= 15:
		state = "medium"
	
	#emit_signal("anger_state_changed", state)
	return state

func student_killed() -> void:
	students_killed += 1
	emit_signal("students_killed_changed", students_killed)

func reset_students_killed() -> void:
	students_killed = 0
	emit_signal("students_killed_changed", students_killed)
