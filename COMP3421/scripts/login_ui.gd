extends Control

const MAIN_SCENE := "res://scenes/main.tscn"

@onready var _username: LineEdit = $CenterPanel/Margin/VBox/UsernameRow/LineEdit
@onready var _password: LineEdit = $CenterPanel/Margin/VBox/PasswordRow/LineEdit
@onready var _error_label: Label = $CenterPanel/Margin/VBox/ErrorLabel
@onready var _login_button: Button = $CenterPanel/Margin/VBox/LoginButton


func _ready() -> void:
	_login_button.pressed.connect(_on_login_pressed)
	_username.text_submitted.connect(_on_username_submitted)
	_password.text_submitted.connect(_on_login_pressed)
	_error_label.text = ""
	_username.grab_focus()


func _on_username_submitted(_text: String) -> void:
	_password.grab_focus()


func _on_login_pressed() -> void:
	var user := _username.text.strip_edges()
	var password := _password.text.strip_edges()

	if user.is_empty() or password.is_empty():
		_show_error("Please enter username and password.")
		return

	if password.length() < 3:
		_show_error("Password must be at least 3 characters.")
		return

	Session.login(user)
	get_tree().change_scene_to_file(MAIN_SCENE)


func _show_error(message: String) -> void:
	_error_label.text = message
