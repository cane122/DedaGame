extends CharacterBody2D

# Movement parameters
@export var speed = 300.0
@export var jump_force = -400.0
@export var gravity = 1200.0
@export var attack_cooldown = 0.5

# State variables
var direction = "move_right"
var is_attacking = false
var can_attack = true
var is_jumping = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_hitbox = $AttackArea/CollisionShape2D

func _physics_process(delta):
	if not is_attacking:
		handle_movement()
		handle_jump()
	apply_gravity(delta)
	handle_attack()
	update_animations()
	
	move_and_slide()

func handle_movement():
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		is_jumping = true
	else:
		is_jumping = false

func handle_attack():
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		attack_hitbox.disabled = false

func update_animations():
	if is_attacking:
		animated_sprite.play("attack")
	elif is_jumping:
		animated_sprite.play("jump")
	elif velocity.x != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
	# Flip sprite based on direction
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

func _on_attack_cooldown_timeout():
	can_attack = true
	is_attacking = false
	attack_hitbox.disabled = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
