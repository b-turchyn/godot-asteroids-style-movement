extends CharacterBody2D

## Rotation speed in [code]radians/second[/code]
@export var rotation_speed: float = TAU
## Rotational acceleration in [code]radians/second^2[/code]
@export var rotational_acceleration: float = TAU * 1
@export var max_speed: float = 600.0
@export var acceleration: float = 600.0
@export var deceleration: float = 10.0

var rotational_velocity: float = 0.0

func _physics_process(delta: float) -> void:
	_linear_acceleration(delta)
	
	move_and_slide()
	print("Speed: %f" % velocity.length())

	
func _linear_acceleration(delta: float) -> void:
	_rotate(delta)
	_move(delta)
	
func _move(delta: float) -> void:
	var forward_direction: float = Input.get_action_strength("forward")
	
	# Add friction
	if forward_direction == 0:
		velocity = velocity.move_toward(Vector2.ZERO, _adjusted_deceleration(delta))
	else:
		velocity += transform.x * forward_direction * _adjusted_acceleration(delta)
		velocity = velocity.limit_length(max_speed)
	
func _rotate(delta: float) -> void:
	var rotation_direction: float = Input.get_axis("left", "right")
	if rotation_direction == 0:
		# An alternative here would be to use move_toward()
		rotation_direction = sign(rotational_velocity) * -1
	rotational_velocity += rotation_direction * rotational_acceleration * delta
	rotational_velocity = clamp(rotational_velocity, -rotation_speed, rotation_speed)
	rotation += rotational_velocity * delta
	
func _adjusted_acceleration(delta: float) -> float:
	return acceleration * delta
	
func _adjusted_deceleration(delta: float) -> float:
	return deceleration * delta
