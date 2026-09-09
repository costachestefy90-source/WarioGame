extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 500.0
const GRAVITY = 1200.0

var mobile_direction := 0.0
var mobile_jump_requested := false
var nudge_direction := 0.0
var nudge_time := 0.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var direction := mobile_direction if mobile_direction != 0.0 else nudge_direction if nudge_time > 0.0 else Input.get_axis("ui_left", "ui_right")
	if nudge_time > 0.0:
		nudge_time -= delta
	else:
		nudge_direction = 0.0
	if Input.is_key_pressed(KEY_A):
		direction = -1.0
	elif Input.is_key_pressed(KEY_D):
		direction = 1.0
	if direction != 0.0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)

	if (Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_W) or mobile_jump_requested) and is_on_floor():
		velocity.y = -JUMP_VELOCITY
	mobile_jump_requested = false

	move_and_slide()

func set_mobile_direction(direction: float) -> void:
	mobile_direction = clampf(direction, -1.0, 1.0)

func clear_mobile_direction() -> void:
	mobile_direction = 0.0

func request_mobile_jump() -> void:
	mobile_jump_requested = true

func nudge_mobile_direction(direction: float) -> void:
	nudge_direction = clampf(direction, -1.0, 1.0)
	nudge_time = 0.45
			
