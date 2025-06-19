extends Node

func _ready():
	$Damage.modulate = Color(1,1,1,0)
	_on_player1_respawn()

func _process(_delta):
	if ($Player1.position[1] > 1000):
		_on_player1_respawn()
	if ($Player2.position[1] > 1000):
		_on_player2_respawn()
	$Camera.position.x = (($Player1.position.x + $Player2.position.x)/2)
	$Camera.position.y = (($Player1.position.y + $Player2.position.y)/2)

# You have to attach the player signals to this each time
func _on_player1_respawn() -> void:
	$Player1.velocity.x = 0
	$Player1.velocity.y = 0
	$Player1.position = $Player1Spawn.position

func _on_player1_hit_area(area: Area2D, number: int) -> void:
	$Player1Spawn.position = area.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated1').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated1').color = Color(1,1,1)


func _on_player2_hit_area(area: Area2D, number: int) -> void:
	$Player2Spawn.position = area.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated2').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated2').color = Color(1,1,1)


func _on_player2_respawn() -> void:
	$Player2.velocity.x = 0
	$Player2.velocity.y = 0
	$Player2.position = $Player2Spawn.position
