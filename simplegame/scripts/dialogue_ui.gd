extends CanvasLayer
class_name DialogueUI

static var instance: DialogueUI

@onready var _panel: PanelContainer = $Panel
@onready var _name_label: Label = $Panel/Margin/VBox/NameLabel
@onready var _text_label: Label = $Panel/Margin/VBox/TextLabel
@onready var _hint_label: Label = $Panel/Margin/VBox/HintLabel

var _lines: PackedStringArray = []
var _line_index: int = 0
var _speaker_name: String = ""
var _is_open: bool = false


func _ready() -> void:
	instance = self
	_panel.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS


func _unhandled_input(event: InputEvent) -> void:
	if not _is_open:
		return
	if (
		event.is_action_pressed("interact")
		or event.is_action_pressed("ui_accept")
		or event.is_action_pressed("ui_cancel")
	):
		_advance_line()
		get_viewport().set_input_as_handled()


func open_dialogue(speaker: String, lines: PackedStringArray) -> void:
	if lines.is_empty():
		return

	_speaker_name = speaker
	_lines = lines
	_line_index = 0
	_is_open = true
	_panel.visible = true
	_set_player_can_move(false)
	_show_current_line()


func _advance_line() -> void:
	_line_index += 1
	if _line_index >= _lines.size():
		close_dialogue()
	else:
		_show_current_line()


func close_dialogue() -> void:
	_is_open = false
	_panel.visible = false
	_set_player_can_move(true)


func is_open() -> bool:
	return _is_open


func _show_current_line() -> void:
	_name_label.text = _speaker_name
	_text_label.text = _lines[_line_index]
	_hint_label.text = "E — Next" if _line_index < _lines.size() - 1 else "E — Close"


func _set_player_can_move(can_move: bool) -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("set_movement_enabled"):
		player.set_movement_enabled(can_move)
