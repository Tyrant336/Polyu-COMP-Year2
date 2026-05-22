extends CanvasLayer
class_name HttpPopupUI

static var instance

const DEFAULT_HTTP_PATH := "res://assets/example.http"

@onready var _panel: PanelContainer = $Panel
@onready var _title_label: Label = $Panel/Margin/VBox/TitleLabel
@onready var _content_label: Label = $Panel/Margin/VBox/ContentLabel
@onready var _hint_label: Label = $Panel/Margin/VBox/HintLabel

var _is_open: bool = false


func _ready() -> void:
	instance = self
	_panel.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS


func _unhandled_input(event: InputEvent) -> void:
	if not _is_open:
		return
	if event.is_action_pressed("interact") or event.is_action_pressed("ui_cancel"):
		close_popup()
		get_viewport().set_input_as_handled()


func open_example_file(http_path: String = DEFAULT_HTTP_PATH) -> void:
	var title := http_path.get_file()
	var body := _load_http_file(http_path)
	_open_panel(title, body, "E or Esc — Close")
	_set_player_can_move(false)


func open_folder_in_browser(folder: String = "") -> void:
	var abs_path := ProjectPaths.resolve_exact_folder(folder)
	if abs_path.is_empty():
		_open_panel("Folder not found", "Could not find this project folder.", "E — Close")
		_set_player_can_move(false)
		return

	var uri := ProjectPaths.path_to_file_uri(abs_path)
	var err := OS.shell_open(uri)
	if err != OK:
		_open_panel(
			"Could not open browser",
			"Could not open this exact folder:\n" + abs_path + "\n\nURL:\n" + uri,
			"E — Close"
		)
		_set_player_can_move(false)
		return

	print("Opened exact project folder: ", abs_path)
	print("Browser URL: ", uri)


func is_open() -> bool:
	return _is_open


func close_popup() -> void:
	_is_open = false
	_panel.visible = false
	_set_player_can_move(true)


func _open_panel(title: String, body: String, hint: String) -> void:
	_is_open = true
	_panel.visible = true
	_title_label.text = title
	_content_label.text = body
	_hint_label.text = hint


func _load_http_file(path: String) -> String:
	if FileAccess.file_exists(path):
		return FileAccess.get_file_as_string(path)
	return "example"


func _set_player_can_move(can_move: bool) -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("set_movement_enabled"):
		player.set_movement_enabled(can_move)
