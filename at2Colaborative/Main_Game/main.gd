extends Node

func _process(delta):
	if($Player.global_position[1] > 10000):
		$Player.position = $PlayerSpawn.position
