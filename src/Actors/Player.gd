extends Actor

export var stomp_impulse: = 700.0

var direction: = Vector2.ZERO


func _on_EnemyDetector_area_entered(_area: Area2D) -> void:
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(_body: PhysicsBody2D) -> void:
	queue_free()


func _physics_process(_delta: float) -> void:
	direction = get_direction()

	velocity = calculate_move_velocity(velocity, direction, speed)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func get_direction() -> Vector2:
	var move_right: = Input.get_action_strength("move_right")
	var move_left: = Input.get_action_strength("move_left")
	var jump: = 0.0
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump = -1.0
	else:
		jump = 1.0
	
	return Vector2(move_right - move_left, jump)


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:

	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0:
		out.y = speed.y * direction.y

	return out


func calculate_stomp_velocity(
		linear_velocity: Vector2,
		impulse: float
	) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse

	return out
