extends StaticBody2D

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

var opened = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ensure the door is in its closed state when the scene starts
	sprite.texture = load("res://Resources/closedDoor.png")

# Called when the player or something else enters the door's area.
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack") and !opened:
		openDoor()

# Logic for opening the door
func openDoor() -> void:
	if opened:
		return

	# Mark the door as opened
	opened = true

	# Change the texture to the opened door texture
	sprite.texture = load("res://Resources/openedDoor.png")
	
	call_deferred("_disable_collision")

	# Optionally, you can add animations here if needed
	# If using an AnimationPlayer for smooth animations:
	# anim_player.play("open")

	# If you want to trigger any other event after the door opens:
	# print("The door has opened!")
func _disable_collision() -> void:
	collision_shape.disabled = true
