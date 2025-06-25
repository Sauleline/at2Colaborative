extends Node

var PlayerOne
var PlayerTwo

func addPlayers(playerone, playertwo):
	PlayerOne = playerone
	PlayerTwo = playertwo
	
func intToSecMin(x: int):
	@warning_ignore("integer_division")
	var minutes = int(x / 60)
	@warning_ignore("integer_division")
	var seconds = x - int(x / 60)*60
	return ("%02d" % minutes) + (":%02d" % seconds)
