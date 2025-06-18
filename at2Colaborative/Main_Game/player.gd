extends CharacterBody2D

signal hitCheckpoint(checkpoint: Area2D, number: int)

@export var speed = 600
@export var jump_speed = -750
@export var gravity = 2000
@export_range(0.0, 1.0) var friction = 0.03
@export_range(0.0 , 1.0) var acceleration = 0.05
@export var level = "Level 10 Crook"

func _ready():
	$"Level Display".text = level

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("p1left", "p1right")
	if (velocity.x < 0):
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("p1jump") and is_on_floor():
		velocity.y = jump_speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().name == "Checkpoints"):
		emit_signal("hitCheckpoint", area, int(area.name))
