extends CharacterBody2D

signal hitArea(area: Area2D, number: int)
signal beatStage()
signal respawn()

@export var speed = 600
@export var jump_speed = -750
@export var wallJumpSpeed = -750
@export var wallJumpHorizontal = 1000
@export var gravity = 2000
@export_range(0.0, 2000) var wallSlideGravity = 250
@export var wall_jump_multiplier = 0.8
@export_range(0.0, 1.0) var friction = 0.06
@export_range(0.0 , 1.0) var acceleration = 0.03
@export var character = "steve"
@export var maxJumps = 1
var jumpCount = maxJumps
var wallSlide = false
var punching = false
var crouch = false
var slopeSlide = false
var slide = false
var slope = 0
var slideAnimation = false
var counter = 0
var crouchAnimation = false
var checkPointTouch = 0 
var dJCheckPointTouch = false
var crouchanimation = false
@onready var front_raycast = $Col_det
var slideFriction = false

func mapRange(x, inMin, inMax, outMin, outMax):
	return ((x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin)

func _ready():
	var hat = "none"
	var colour = Color(1,1,1)
	if (Global.PlayerOne):
		var player = Global.PlayerOne
		hat = player.currentHat
		colour = player.colour
		$"Level Display".text = player.userName
	else:
		$"Level Display".text = "Guest"
	var hatTexture = "res://art/hats/"+hat+".png"
	$Hat.texture = load(hatTexture)
	$Sprite.self_modulate = colour
	$Sprite.play('Idle')

func _physics_process(delta):
	move_and_slide()
	if slopeSlide == false:
		velocity.y += gravity * delta

	#if Input.is_action_just_pressed("p1punch") and is_on_floor():
		#player_punch()
	if Input.is_action_just_pressed("p1shoot"):
		player_shoot()
	
	var dir = Input.get_axis("p1left", "p1right")
	if punching:
		dir = 0
	if (dir == -1):
		$Sprite.flip_h = true
		$Hat.flip_h = false

	elif (dir == 1):
		$Sprite.flip_h = false
		$Hat.flip_h = true
	
	if is_on_floor():
		jumpCount = maxJumps
		slope = get_floor_normal().y
	
	if Input.is_action_just_pressed("p1jump") and (jumpCount > 0) and (wallSlide == false) and not punching:
		velocity.y = jump_speed
		jumpCount -= 1
		$SFX/Jump.play()
	
	if (is_on_wall() and not is_on_floor()) and (velocity.y > 0) and wallSlide == false :
		if Input.is_action_pressed("p1left") or ("p1right"):
			wallSlide = true
			gravity = gravity * 0.125
			
	if checkPointTouch > 2 and dJCheckPointTouch == false:
		maxJumps = 2
		dJCheckPointTouch = true
	

	if (is_on_floor() or not is_on_wall() or (velocity.y <= 0)) and wallSlide == true :
		wallSlide = false
		gravity = gravity * 8
	
	if Input.is_action_just_pressed("p1jump") and (wallSlide == true) and checkPointTouch >1:
		velocity.y = wallJumpSpeed
		$SFX/Jump.play()
		if Input.is_action_pressed("p1left"):
			velocity.x = wallJumpHorizontal
		if Input.is_action_pressed("p1right"):
			velocity.x = wallJumpHorizontal * -1
		wallSlide = false
		gravity = gravity * 8
		
	if Input.is_action_pressed("p1slide") and (crouch == false):
		gravity = gravity * 2
		crouch = true
		
	if not Input.is_action_pressed("p1slide") and (crouch == true):
		gravity = gravity * 0.5
		crouch = false
		crouchAnimation = false
		
		
	if (crouch == true) and is_on_floor() and (velocity.x != 0) and (slide == false) and checkPointTouch >2:
		slide = true
		counter = 0 
		friction -= 0.04
		
	if ((crouch == false) or not is_on_floor() or  (velocity.x == 0)) and (slide ==true) :
		slide = false
		friction += 0.04
		slideAnimation = false
		
	if slide == true and slope != -1:
		front_raycast.force_raycast_update()
		if not front_raycast.is_colliding():
			print(velocity.y)
			slopeSlide = true 
			velocity.x = velocity.x * 1.15
			velocity.y = velocity.x
		else:
			velocity.x = velocity.x * 0.95

			
			
		
	if slopeSlide == true and (slope == -1 or not is_on_floor() or velocity.x == 0):
		slopeSlide = false

		
	if dir != 0 and (slide == false):
		if is_on_floor():
			if slideAnimation == false:
				$Sprite.play('Run')
		else:
			if slideAnimation == false:
				$Sprite.play("Jump")
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		if is_on_floor() and not punching:
			if velocity.x != 0:
				if slideAnimation == false:
					$Sprite.play("Walk")
			else:
				if slideAnimation == false and crouchAnimation == false:
					$Sprite.play("Idle")
		else:
			$Sprite.play("Jump")
		velocity.x = lerp(velocity.x, 0.0, friction)

	if velocity.x > 0:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, -30))
	elif velocity.x < 0:
		$Hat.rotation = deg_to_rad(mapRange(abs(velocity.x), 0, 600, 0, 30))
	
	
	
	if wallSlide:
		$Sprite.play("WallHold")
		
	if crouch:
		if slide == true:
			counter += 1
		if slide == true and slideAnimation == false and (counter <= 20):
			$Sprite.play("Roll")
			slideAnimation = true
		if slide == true and slideAnimation == true and (counter  > 20):
			$Sprite.play("Slide")
		if slide == false and crouchAnimation == false and velocity.x == 0 :
			crouchAnimation = true
			$Sprite.play("Crouch")

func player_shoot():
	pass

#func player_punch():
	#punching = true
	#$Sprite.play("Punch")
	#$Fist/FistHitbox.disabled = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().name == "Checkpoints"):
		if area.find_child("Activated1").color == Color(1, 1, 1):
			checkPointTouch += 1
		emit_signal("hitArea", area, int(area.name))

	if (area.name == "End"):
		emit_signal("beatStage")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Damage"):
		emit_signal("respawn")
