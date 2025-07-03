extends Node

@onready var score = 0

func _ready():
	$Damage.modulate = Color(1,1,1,0)
	$"Score Timer".wait_time = 0.1
	$"Score Timer".start()
	$Camera/HUD/Gameplay/Time.visible = false
	$Camera/HUD/Gameplay/DeathCount.visible = false
	_on_player_1_respawn()
	_on_player_2_respawn()

func _process(_delta):
	$Camera.position[0] = ($Player1.position[0]+$Player2.position[0])/2
	$Camera.position[1] = ($Player1.position[1]+$Player2.position[1])/2
	
	if Input.is_action_just_pressed("pause"):
		$"Camera/Pause Menu".show()
		get_tree().paused = true
	
	if ($Player1.position[1] > 1000):
		_on_player_1_respawn()
		
	if ($Player2.position[1] > 1000):
		_on_player_2_respawn()

func _on_player_1_respawn() -> void:
	$Player1.velocity.x = 0
	$Player1.velocity.y = 0
	$Player1.position = $Player1Spawn.position
	$Player1.jumpCount = $Player1.maxJumps

func _on_player_2_respawn() -> void:
	$Player2.velocity.x = 0
	$Player2.velocity.y = 0
	$Player2.position = $Player2Spawn.position
	$Player2.jumpCount = $Player2.maxJumps

func _on_player_1_hit_area(area: Area2D, number: int) -> void:
	$Player1Spawn.position = area.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated1').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated1').color = Color(1,1,1)

func _on_player_2_hit_area(area: Area2D, number: int) -> void:
	$Player2Spawn.position = area.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated2').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated2').color = Color(1,1,1)

func stageWon(playerNum: int):
	if playerNum == 1:
		$Camera/HUD/WinScreen.text = Global.PlayerOne.userName + " Wins!"
	else:
		$Camera/HUD/WinScreen.text = Global.PlayerTwo.userName + " Wins!"
	$Camera/HUD/WinScreen.visible = true
	$Camera/HUD/Blur.visible = true
	print(playerNum)
