extends Node2D

@export var sprite1_texture: Texture2D
@export var sprite2_texture: Texture2D
@export var sprite3_texture: Texture2D
@export var sad_music: AudioStream
@export var main_scene: String

@onready var audio_player = $AudioStreamPlayer
@onready var animation_player = $AnimationPlayer
@onready var sprite_container = $SpriteContainer

var current_sprite: int = 0
var sprites: Array = []
var sprite_paths: Array = [
	"res://Resources/pic1.png",
	"res://Resources/pic2.png",
	"res://Resources/pic3.png"
]

func _ready():
	
	for path in sprite_paths:
		var sprite = Sprite2D.new()
		sprite.texture = load(path)
		sprite.modulate.a = 0
		sprite_container.add_child(sprite)
		sprites.append(sprite)
	
	# Set up music
	audio_player.stream = sad_music
	audio_player.play()
	
	# Start sequence
	animation_player.play("intro2")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		finish_sequence()

func finish_sequence():
	animation_player.stop()
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _on_animation_finished(anim_name):
	finish_sequence()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	finish_sequence()
