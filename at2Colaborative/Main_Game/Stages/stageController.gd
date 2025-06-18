extends Node

func _ready():
	$Player.position = $PlayerSpawn.position

func _process(_delta):
	if ($Player.position[1] > 1000):
		$Player.position = $PlayerSpawn.position

func _on_player_hit_checkpoint(checkpoint: Area2D, number:int):
	$PlayerSpawn.position = checkpoint.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated').color = Color(1,1,1)
