extends CharacterBody2D

# Movement parameters
@export var speed = 280.0
@export var jump_force = -350.0
@export var gravity = 1250.0

# State variables
var direction = "move_right"
var is_attacking = false
var is_jumping = false
var counter = 0

@onready var coyote_timer = $CoyoteTime
@onready var gravity_timer = $GravityTimer
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_hitbox = $AttackArea/CollisionShape2D

func _physics_process(delta):
	var was_on_floor = is_on_floor()
	
	handle_movement()
	handle_jump()
	
	apply_gravity(delta)
	handle_attack()
	update_animations()
	move_and_slide()
	
	if was_on_floor == !is_on_floor():
		coyote_timer.start()

func handle_movement():
	direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

func handle_jump():
	if Input.is_action_just_pressed("jump") and (is_on_floor() or !coyote_timer.is_stopped()):
		velocity.y = jump_force
		is_jumping = true

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		is_jumping = true
	else:
		is_jumping = false

func handle_attack():
	if Input.is_action_just_pressed("attack") and !is_attacking:
		is_attacking = true
		attack_hitbox.disabled = false
		# Play the attack animation
		#animated_sprite.play("attack")
		
		# Use a timer to disable the hitbox after the attack duration
		$AttackTimer.start()


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


func _on_attack_timer_timeout() -> void:
	is_attacking = false
	attack_hitbox.disabled = true
