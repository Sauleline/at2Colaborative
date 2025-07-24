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
	$Player/Camera/HUD/Gameplay/Time.text = Global.intToSecMin(floor(score/10))

# You have to attach the player signals to this each time
func _on_player_respawn() -> void:
	deaths += 1
	$Player/Camera/HUD/Gameplay/DeathCount.text = "Deaths: " + str(deaths)
	$Player.velocity.x = 0
	$Player.velocity.y = 0
	$Player.position = $PlayerSpawn.position
	$Player.jumpCount = $Player.maxJumps

func _on_player_hit_area(area: Area2D, number: int) -> void:
	$PlayerSpawn.position = area.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).monitoring = false
			$Checkpoints.get_child(i).find_child('Activated1').color = Color(0,1,0)
			$Checkpoints.get_child(i).find_child('Activated2').color = Color(0,1,0)

func _on_score_timer_timeout() -> void:
	score += 1
	

func _update_personal_best_score(score):
	var p1 = AccessUsers.open_user(Global.PlayerOne.userName)
	if p1.personalBestScores[0] > score:
		p1.personalBestScores.update({0:score})
		AccessUsers.save_user(p1)
	else:
		pass

func _on_player_beat_stage() -> void:
	$"Score Timer".stop()
	_update_personal_best_score(score)
	for i in $Player/Camera/HUD/Gameplay.get_children():
		i.visible = false
	$Player/Camera/HUD/ScoreScreen.visible = true
	$Player/Camera/HUD/Blur.visible = true
	@warning_ignore("integer_division")
	$Player/Camera/HUD/ScoreScreen.text = "You died " + str(deaths) + " times\nand took " + str(Global.intToSecMin(floor(score/10)))
