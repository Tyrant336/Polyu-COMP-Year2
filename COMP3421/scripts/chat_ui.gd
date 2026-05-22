extends CanvasLayer
class_name ChatUI

static var instance

const COLOR_PLAYER_BUBBLE := Color(0.86, 0.97, 0.78, 1)
const COLOR_TELEPHONE_BUBBLE := Color(0.72, 0.75, 0.8, 1)
const COLOR_TELEPHONE_TEXT := Color(0.12, 0.14, 0.18, 1)
const MANAGER_REPLY_DELAY := 1.0
const MAX_BUBBLE_WIDTH := 220.0

@onready var _chat_icon: Button = $ChatIcon
@onready var _chat_panel: PanelContainer = $ChatPanel
@onready var _scroll: ScrollContainer = $ChatPanel/Margin/VBox/ScrollContainer
@onready var _messages: VBoxContainer = $ChatPanel/Margin/VBox/ScrollContainer/MessagesVBox
@onready var _input: LineEdit = $ChatPanel/Margin/VBox/InputRow/LineEdit
@onready var _send_button: Button = $ChatPanel/Margin/VBox/InputRow/SendButton
@onready var _title_label: Label = $ChatPanel/Margin/VBox/TitleLabel

var _is_open: bool = false
var _welcomed: bool = false
var _waiting_reply: bool = false


func _ready() -> void:
	instance = self
	_chat_panel.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	_title_label.text = "Telephone"
	_chat_icon.text = "Telephone"

	_chat_icon.pressed.connect(_open_chat)
	_send_button.pressed.connect(_submit_current_line)
	_input.text_submitted.connect(_on_text_submitted)


func _unhandled_input(event: InputEvent) -> void:
	if not _is_open:
		return
	if event.is_action_pressed("ui_cancel"):
		close_chat()
		get_viewport().set_input_as_handled()


func is_open() -> bool:
	return _is_open


func _open_chat() -> void:
	if _is_open:
		return
	if UiState.is_blocking():
		return

	_is_open = true
	_chat_panel.visible = true
	_set_player_can_move(false)
	_input.grab_focus()

	if not _welcomed:
		_welcomed = true
		if Session.is_logged_in:
			_add_system_note("Logged in as " + Session.username)
		_add_system_note("You (left) · Telephone (right)")


func close_chat() -> void:
	_is_open = false
	_waiting_reply = false
	_chat_panel.visible = false
	_input.editable = true
	_send_button.disabled = false
	_input.release_focus()
	_set_player_can_move(true)


func _submit_current_line() -> void:
	_on_text_submitted(_input.text)


func _on_text_submitted(text: String) -> void:
	if _waiting_reply:
		return

	var message := text.strip_edges()
	if message.is_empty():
		return

	_waiting_reply = true
	_input.editable = false
	_send_button.disabled = true

	_add_message_bubble(message, true)
	_input.clear()
	_scroll_to_bottom()

	await get_tree().create_timer(MANAGER_REPLY_DELAY).timeout

	_waiting_reply = false
	_input.editable = true
	_send_button.disabled = false

	if not _is_open:
		return

	_add_message_bubble(message + " :)", false)
	_scroll_to_bottom()
	_input.grab_focus()


func _add_message_bubble(text: String, is_player: bool) -> void:
	var row := HBoxContainer.new()
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	if not is_player:
		var spacer_left := Control.new()
		spacer_left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_child(spacer_left)

	row.add_child(_create_bubble(text, is_player))

	if is_player:
		var spacer_right := Control.new()
		spacer_right.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.add_child(spacer_right)

	_messages.add_child(row)


func _create_bubble(text: String, is_player: bool) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER

	var style := StyleBoxFlat.new()
	style.bg_color = COLOR_PLAYER_BUBBLE if is_player else COLOR_TELEPHONE_BUBBLE
	style.corner_radius_top_left = 10
	style.corner_radius_top_right = 10
	style.corner_radius_bottom_left = 10
	style.corner_radius_bottom_right = 10
	style.content_margin_left = 10
	style.content_margin_right = 10
	style.content_margin_top = 6
	style.content_margin_bottom = 6
	panel.add_theme_stylebox_override("panel", style)

	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	if not is_player:
		label.add_theme_color_override("font_color", COLOR_TELEPHONE_TEXT)
	label.custom_minimum_size.x = 40.0
	label.custom_minimum_size.y = 0.0

	var text_width := MAX_BUBBLE_WIDTH * 0.5
	var font := label.get_theme_font("font")
	var font_size := label.get_theme_font_size("font_size")
	if font:
		text_width = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
	label.custom_minimum_size.x = minf(text_width + 8.0, MAX_BUBBLE_WIDTH)

	panel.add_child(label)
	return panel


func _add_system_note(text: String) -> void:
	var label := Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 11)
	label.add_theme_color_override("font_color", Color(0.55, 0.55, 0.55, 1))
	_messages.add_child(label)


func _scroll_to_bottom() -> void:
	await get_tree().process_frame
	var bar := _scroll.get_v_scroll_bar()
	if bar:
		bar.value = bar.max_value


func _set_player_can_move(can_move: bool) -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("set_movement_enabled"):
		player.set_movement_enabled(can_move)
