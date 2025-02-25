##

extends CharacterBody2D

## Rotation speed, in [code]radians/second[/code]. [member PI] is half a circle, or 180 degrees.
@export var rotation_speed: float = PI
## Movement speed, in [code]pixels/second[/code]
@export var max_speed: float = 600.0

func _physics_process(delta: float) -> void:
	_do_rotate(delta)
	_do_move()
	
func _do_rotate(delta: float) -> void:
	var rotation_amount: float = Input.get_axis("left", "right")
	# You could also instead adjust the rotation property, i.e.
	# 	rotation =+ rotation_speed * rotation_amount * delta
	# Both work!
	rotate(rotation_speed * rotation_amount * delta)
	
func _do_move() -> void:
	var movement_amount: float = Input.get_action_strength("forward")
	velocity = movement_amount * max_speed * Vector2.RIGHT.rotated(rotation) # transform.x also works for us
	move_and_slide()
