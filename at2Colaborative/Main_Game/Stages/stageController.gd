extends Node

func _ready():
	$Player.position = $PlayerSpawn.position

func _process(delta):
	if ($Player.position[1] > 1000):
		$Player.position = $PlayerSpawn.position
