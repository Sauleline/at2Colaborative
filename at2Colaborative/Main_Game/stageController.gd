extends Node

@onready var score = 0
@onready var deaths = -1

func _ready():
	$Damage.modulate = Color(1,1,1,0)
	$"Score Timer".wait_time = 0.1
	$"Score Timer".start()
	_on_player_respawn()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		$"Player/Camera/Pause Menu".show()
		get_tree().paused = true
	
	if ($Player.position[1] > 1000):
		_on_player_respawn()
	
	@warning_ignore("integer_division")
	$Player/Camera/HUD/Time.text = Global.intToSecMin(score/10)

# You have to attach the player signals to this each time
func _on_player_respawn() -> void:
	deaths += 1
	$Player/Camera/HUD/DeathCount.text = "Deaths: " + str(deaths)
	$Player.velocity.x = 0
	$Player.velocity.y = 0
	$Player.position = $PlayerSpawn.position
	$Player.jumpCount = 2

func _on_player_hit_area(area: Area2D, number: int) -> void:
	$PlayerSpawn.position = area.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated1').color = Color(0,1,0)
			$Checkpoints.get_child(i).find_child('Activated2').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated1').color = Color(1,1,1)
			$Checkpoints.get_child(i).find_child('Activated2').color = Color(1,1,1)

func _on_score_timer_timeout() -> void:
	score += 1
