extends CharacterBody2D

signal hitCheckpoint(checkpoint: Area2D, number: int)
signal respawn()

@export var speed = 600
@export var jump_speed = -750
@export var gravity = 2000
@export_range(0.0, 1.0) var friction = 0.03
@export_range(0.0 , 1.0) var acceleration = 0.05
@export var level = "Level 10 Crook"

func _ready():
	$"Level Display".text = level
	if ($Sprite.animation == "Jackson"):
		$Sprite.scale.x = 0.08
		$Sprite.scale.y = 0.08
	elif ($Sprite.animation == "Joel"):
		$Sprite.scale.x = 0.067
		$Sprite.scale.y = 0.067
	elif ($Sprite.animation == "Dame Da Ne Guy"):
		$Sprite.scale.x = 0.149
		$Sprite.scale.y = 0.069
	elif ($Sprite.animation == "Pluey"):
		$Sprite.scale.x = 0.133
		$Sprite.scale.y = 0.133
		
func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("p1left", "p1right")
	if (velocity.x < 0):
		$Sprite.flip_h = false
		$"Hat Marker/Hat".flip_h = false
	else:
		$Sprite.flip_h = true
		$"Hat Marker/Hat".flip_h = true
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	if Input.is_action_just_pressed("p1jump") and is_on_floor():
		velocity.y = jump_speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().name == "Hitboxes"):
		emit_signal("respawn")
	if (area.get_parent().name == "Checkpoints"):
		emit_signal("hitCheckpoint", area, int(area.name))
