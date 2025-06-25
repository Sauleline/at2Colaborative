extends CharacterBody2D

signal hitArea(area: Area2D, number: int)
signal respawn()

@export var speed = 600
@export var jump_speed = -750
@export var gravity = 2000
@export var wall_jump_multiplier = 0.8
@export_range(0.05, 2) var punchTime = 0.2
@export_range(0.0, 1.0) var friction = 0.06
@export_range(0.0 , 1.0) var acceleration = 0.05
var jumpCount = 2
var wallSlide = false


func mapRange(x, inMin, inMax, outMin, outMax):
	return ((x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin)

var scaleMap = {"Jackson": [0.08, 0.08],
				"Joel": [0.067, 0.067],
				"Dame Da Ne Guy": [0.149, 0.069],
				"Pluey": [0.133, 0.133]}

func _ready():
	if (Global.PlayerOne):
		var player = Global.PlayerOne
		$"Level Display".text = player.userName
	else:
		$"Level Display".text = "Guest"
	$Sprite.scale.x = scaleMap[$Sprite.animation][0]
	$Sprite.scale.y = scaleMap[$Sprite.animation][1]
		
func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("p1left", "p1right")
	if (dir == -1):
		$Sprite.flip_h = false
		$Hat.flip_h = false
		$Fist.rotation = deg_to_rad(180)
	elif (dir == 1):
		$Sprite.flip_h = true
		$Hat.flip_h = true
		$Fist.rotation = deg_to_rad(0)
	if Input.is_action_just_pressed("p1punch"):
		$Fist/FistHitbox.disabled = false
		$Fist/ColorRect.visible = true
		await get_tree().create_timer(punchTime).timeout
		$Fist/FistHitbox.disabled = true
		$Fist/ColorRect.visible = false
	if Input.is_action_just_pressed("p1shoot"):
		player_shoot()
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	if velocity.x > 0:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, -30))
	else:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, 30))
	move_and_slide()
	if is_on_floor():
		jumpCount = 2
	if Input.is_action_just_pressed("p1jump") and (jumpCount > 0):
		velocity.y = jump_speed
		jumpCount -= 1
	if is_on_wall() and not is_on_floor():
		if Input.is_action_just_pressed("p1left") or ("p1right"):
			var wallSlide = true
		

func player_shoot():
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().name == "Checkpoints"):
		emit_signal("hitArea", area, int(area.name))

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Damage"):
		emit_signal("respawn")
