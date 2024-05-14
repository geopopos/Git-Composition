extends Node2D

class_name TopDownVelocityAI

@export var actor: CharacterBody2D
@export var top_down_movement_stats: TopDownMovementStats
@export var search_radius_scale: float = 1
@export var target_group = "players"

#var target_body: CharacterBody2D
var target_body_array: Array[CharacterBody2D]


func _ready():
	$Area2D/CollisionShape2D.scale = Vector2(search_radius_scale, search_radius_scale)

func _physics_process(delta):
	if target_body_array:
		# get direction from enemy to target body
		var direction = global_position.direction_to(target_body_array[0].global_position)
		actor.velocity = actor.velocity.move_toward(direction * top_down_movement_stats.max_speed, top_down_movement_stats.acceleration * delta)
	else:
		actor.velocity = actor.velocity.move_toward(Vector2.ZERO, top_down_movement_stats.friction * delta)


func _on_area_2d_body_entered(body):
	if body.is_in_group("players"):
		#target_body = body
		target_body_array.append(body)
		print("new target acquired ", body)
		print("target queue ", target_body_array)
		


func _on_area_2d_body_exited(body):
	if target_body_array:
		var index = target_body_array.find(body)
		if index == -1:
			pass
		var target_body = target_body_array.pop_at(index)
		print("no longer targeting ", target_body)
		print("target queue ", target_body_array)
