# anger_manager.gd
extends Node

signal anger_changed(new_value: int)
signal students_killed_changed(new_value: int)

var anger: int = 0
var students_killed: int = 0

func _ready() -> void:
	# Initialize with default values when game starts
	anger = 0
	students_killed = 0

func modify_anger(amount: int) -> void:
	anger = clamp(anger + amount, 0, 30)
	emit_signal("anger_changed", anger)
	
	# Check anger thresholds and update game state
	check_anger_effects()

func check_anger_effects() -> void:
	# This will be connected to by sprites/effects in the game
	if anger >= 30:
		# Maximum anger state - all effects active
		emit_signal("anger_state_changed", "max")
	elif anger >= 15:
		# Medium anger state - some effects active
		emit_signal("anger_state_changed", "medium")
	else:
		# Minimum anger state - no effects
		emit_signal("anger_state_changed", "min")

func student_killed() -> void:
	students_killed += 1
	emit_signal("students_killed_changed", students_killed)

func reset_students_killed() -> void:
	students_killed = 0
	emit_signal("students_killed_changed", students_killed)
