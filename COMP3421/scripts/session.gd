extends Node

## Stores the logged-in player name between scenes.

var username: String = ""
var is_logged_in: bool = false


func login(user: String) -> void:
	username = user
	is_logged_in = true


func logout() -> void:
	username = ""
	is_logged_in = false
