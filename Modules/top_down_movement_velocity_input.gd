extends Node

class_name TopDownMovementVelocityInput


@export var actor: CharacterBody2D
@export var top_down_movement_stats: TopDownMovementStats

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input.length() > 0:
		actor.velocity = actor.velocity.move_toward(input * top_down_movement_stats.max_speed, top_down_movement_stats.acceleration * delta)
	else:
		actor.velocity = actor.velocity.move_toward(Vector2.ZERO, top_down_movement_stats.friction * delta)
		
