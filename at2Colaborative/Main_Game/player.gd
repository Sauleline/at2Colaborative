extends CharacterBody2D

signal hitArea(area: Area2D, number: int)
signal respawn()

@export var speed = 600
@export var jump_speed = -750
@export var gravity = 2000
@export_range(0.0, 1.0) var friction = 0.06
@export_range(0.0 , 1.0) var acceleration = 0.05
@export var userName = "Level 10 Crook"

func mapRange(x, inMin, inMax, outMin, outMax):
	return ((x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin)

var scaleMap = {"Jackson": [0.08, 0.08],
				"Joel": [0.067, 0.067],
				"Dame Da Ne Guy": [0.149, 0.069],
				"Pluey": [0.133, 0.133]}

func _ready():
	$"Level Display".text = userName
	$Sprite.scale.x = scaleMap[$Sprite.animation][0]
	$Sprite.scale.y = scaleMap[$Sprite.animation][1]
		
func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("p1left", "p1right")
	if (dir == -1):
		$Sprite.flip_h = false
		$Hat.flip_h = false
	elif (dir == 1):
		$Sprite.flip_h = true
		$Hat.flip_h = true
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	if velocity.x > 0:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, -30))
	else:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, 30))
	move_and_slide()
	if Input.is_action_just_pressed("p1jump") and is_on_floor():
		velocity.y = jump_speed

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().name == "Checkpoints"):
		emit_signal("hitArea", area, int(area.name))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Damage"):
		emit_signal("respawn")
