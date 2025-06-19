extends Node

func _ready():
	$Damage.visible = false
	_on_player_respawn()

func _process(_delta):
	if ($Player.position[1] > 1000):
		_on_player_respawn()

# You have to attach the player signals to this each time
func _on_player_respawn() -> void:
	$Player.velocity.x = 0
	$Player.velocity.y = 0
	$Player.position = $PlayerSpawn.position

func _on_player_hit_area(area: Area2D, number: int) -> void:
	$PlayerSpawn.position = area.position
	for i in len($Checkpoints.get_children()):
		if(int($Checkpoints.get_child(i).name) == number):
			$Checkpoints.get_child(i).find_child('Activated').color = Color(0,1,0)
		else:
			$Checkpoints.get_child(i).find_child('Activated').color = Color(1,1,1)
