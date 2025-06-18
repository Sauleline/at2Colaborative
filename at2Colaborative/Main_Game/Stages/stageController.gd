extends Node

func _ready():
	_on_player_respawn()

func _process(_delta):
	if ($Player.position[1] > 1000):
		_on_player_respawn()

func _on_player_hit_checkpoint(checkpoint: Area2D, number:int):
	$PlayerSpawn.position = checkpoint.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated').color = Color(1,1,1)


func _on_player_respawn() -> void:
	$Player.position = $PlayerSpawn.position
