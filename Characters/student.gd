extends CharacterBody2D

@export var dying_speed: float = 50.0

# State variables
var dying_enabled: bool = false
var is_dead: bool = false
var dying_direction: Vector2 = Vector2.ZERO

# Preload sprites for better performance
var student_sprites: Array[String] = [
	"res://Resources/students/student.png",
	"res://Resources/students/2student.png",
	"res://Resources/students/3student.png",
	"res://Resources/students/4student.png"
]

var dead_student_sprites: Array[String] = [
	"res://Resources/students/mrtav.png",
	"res://Resources/students/2mrtav.png",
	"res://Resources/students/3mrtav.png",
	"res://Resources/students/4mrtav.png"
]

var evil_student_sprites: Array[String] = [
	"res://Resources/students/zlistudent.png",
	"res://Resources/students/2zlistudent.png",
	"res://Resources/students/3zao.png",
	"res://Resources/students/4zao.png"
]

var dead_evil_student_sprites: Array[String] = [
	"res://Resources/students/mrtavzao.png",
	"res://Resources/students/2mrtavzao.png",
	"res://Resources/students/3mrtavzao.png",
	"res://Resources/students/4mrtavzao.png"
]

# Cache loaded textures
var cached_textures: Dictionary = {}
var current_sprite_index: int = 0

@onready var sprite: Sprite2D = $Sprite2D
@onready var detection_area: Area2D = $DetectionArea

func _ready() -> void:
	# Preload all textures
	for path in student_sprites + dead_student_sprites + evil_student_sprites + dead_evil_student_sprites:
		cached_textures[path] = load(path)
	initialize_student()

func initialize_student() -> void:
	current_sprite_index = randi() % student_sprites.size()
	update_sprite()
	set_dying_direction()
	
func update_sprite() -> void:
	var sprite_path: String

	if is_dead:
		sprite_path = dead_student_sprites[current_sprite_index] if AngerManager.check_anger_effects() == "min" else dead_evil_student_sprites[current_sprite_index]
	else:
		sprite_path = student_sprites[current_sprite_index] if AngerManager.check_anger_effects() == "min" else evil_student_sprites[current_sprite_index]
	
	sprite.texture = cached_textures[sprite_path]

func _physics_process(delta: float) -> void:
	if dying_enabled:
		move_student(delta)

func move_student(delta: float) -> void:
	velocity = dying_direction * dying_speed
	move_and_slide()

func set_dying_direction() -> void:
	dying_direction = Vector2(0, -1)

func toggle_dying(enable: bool) -> void:
	dying_enabled = enable

func take_damage() -> void:
	if is_dead:
		return
	
	is_dead = true
	AngerManager.student_killed()
	update_sprite()
	toggle_dying(true)

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_attack") and not is_dead:
		take_damage()
