extends CharacterBody2D

signal hitArea(area: Area2D, number: int)
signal beatStage()
signal respawn()

@export var speed = 600
@export var jump_speed = -750
@export var wallJumpSpeed = -750
@export var wallJumpHorizontal = 1000
@export var gravity = 2000
@export_range(0.0, 2000) var wallSlideGravity = 1000
@export var wall_jump_multiplier = 0.8
@export_range(0.0, 1.0) var friction = 0.06
@export_range(0.0 , 1.0) var acceleration = 0.03
@export var character = "steve"
@export var maxJumps = 1
var jumpCount = maxJumps
var wallSlide = false
var punching = false

func mapRange(x, inMin, inMax, outMin, outMax):
	return ((x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin)

func _ready():
	if (Global.PlayerOne):
		var player = Global.PlayerOne
		$"Level Display".text = player.userName
		$Hat.play(player.currentHat)
	else:
		$"Level Display".text = "Guest"
		$Hat.play("none")
	$Sprite.play(character+'Idle')

func _physics_process(delta):
	velocity.y += gravity * delta

	if Input.is_action_just_pressed("p1punch") and is_on_floor():
		player_punch()
	if Input.is_action_just_pressed("p1shoot"):
		player_shoot()
	
	var dir = Input.get_axis("p1left", "p1right")
	if punching:
		dir = 0
	if (dir == -1):
		$Sprite.flip_h = true
		$Hat.flip_h = false
		$Fist.rotation = deg_to_rad(180)
	elif (dir == 1):
		$Sprite.flip_h = false
		$Hat.flip_h = true
		$Fist.rotation = deg_to_rad(0)
	
	if Input.is_action_just_pressed("p1jump") and (jumpCount > 0) and (wallSlide == false) and not punching:
		velocity.y = jump_speed
		jumpCount -= 1
		$SFX/Jump.play()
	
	if (is_on_wall() and not is_on_floor()) and (velocity.y > 0) and wallSlide == false :
		if Input.is_action_pressed("p1left") or ("p1right"):
			wallSlide = true
			gravity = wallSlideGravity
	

	if (is_on_floor() or not is_on_wall() or (velocity.y <= 0)) and wallSlide == true :
		wallSlide = false
		gravity = 2000
	
	if Input.is_action_just_pressed("p1jump") and (wallSlide == true):
		velocity.y = wallJumpSpeed
		$SFX/Jump.play()
		if Input.is_action_pressed("p1left"):
			velocity.x = wallJumpHorizontal
		if Input.is_action_pressed("p1right"):
			velocity.x = wallJumpHorizontal * -1
		wallSlide = false
		gravity = 2000

	if dir != 0:
		if is_on_floor():
			$Sprite.play(character+'Run')
		else:
			$Sprite.play(character+"Jump")
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		if is_on_floor() and not punching:
			if velocity.x != 0:
				$Sprite.play(character+"Walk")
			else:
				$Sprite.play(character+"Idle")
		velocity.x = lerp(velocity.x, 0.0, friction)

	if velocity.x > 0:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, -30))
	elif velocity.x < 0:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, 30))
	
	if is_on_floor():
		jumpCount = maxJumps
	
	if wallSlide:
		$Sprite.play(character+"WallHold")
	
	move_and_slide()

func player_shoot():
	pass

func player_punch():
	punching = true
	$Sprite.play(character+"Punch")
	$Fist/FistHitbox.disabled = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().name == "Checkpoints"):
		emit_signal("hitArea", area, int(area.name))
	if (area.name == "End"):
		emit_signal("beatStage")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Damage"):
		emit_signal("respawn")

func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == character+"Punch":
		punching = false
		$Fist/FistHitbox.disabled = true
