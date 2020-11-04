extends "res://src/Actors/Actor.gd"


export var score: = 50

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	die()


func _physics_process(delta: float) -> void:
	velocity.x *= -1.0 if is_on_wall() else 1.0
	velocity.y += gravity * delta
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y


func die() -> void:
	queue_free()
	PlayerData.score += score
