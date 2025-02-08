extends CharacterBody2D

# Student properties
@export var dying_speed := 50.0

# State variables
var dying_enabled := false
var is_dead := false
var dying_direction := Vector2.ZERO

@onready var sprite = $Sprite2D
@onready var detection_area = $DetectionArea

func _ready():
	initialize_student()
	
func initialize_student():
	# Load textures from Resources directory
	sprite.texture = load("res://Resources/student.png")
	set_dying_direction()

func _physics_process(delta):
	if dying_enabled:
		move_student(delta)

func move_student(delta):
	velocity = dying_direction * dying_speed
	move_and_slide()

func set_dying_direction():
	dying_direction = Vector2(0, -1)

func toggle_dying(enable: bool):
	dying_enabled = enable

func take_damage():
	if is_dead:
		return
	print("umro sam")
	is_dead = true
	sprite.texture = load("res://Resources/mrtavStudent.png")
	toggle_dying(true)
	# Optional: Add death effects or sound here

func _on_detection_area_area_entered(body):
	if body.is_in_group("player_attack") && !is_dead:
		take_damage()
