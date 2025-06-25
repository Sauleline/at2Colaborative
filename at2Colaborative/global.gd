extends Node

var PlayerOne
var PlayerTwo

func addPlayers(playerone, playertwo):
	PlayerOne = playerone
	PlayerTwo = playertwo
	
func intToSecMin(x: int):
	@warning_ignore("integer_division")
	return str(floor(x/60))+":"+str(x-(floor(x/60)*60)).pad_zeros(2)
