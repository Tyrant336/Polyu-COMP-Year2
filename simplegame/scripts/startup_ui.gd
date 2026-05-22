extends Control

const LOGIN_SCENE := "res://scenes/login.tscn"


func _ready() -> void:
	$BottomPanel/Margin/VBox/ContinueButton.pressed.connect(_go_to_login)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("interact"):
		_go_to_login()
		get_viewport().set_input_as_handled()


func _go_to_login() -> void:
	get_tree().change_scene_to_file(LOGIN_SCENE)
