extends Node2D

enum OpenMode { OPEN_FOLDER, OPEN_EXAMPLE }

@export var zone_label: String = "Computer"
@export var open_mode: OpenMode = OpenMode.OPEN_FOLDER
@export var http_file_path: String = "res://example.http"
@export var folder_path: String = ""
@export var interact_radius: float = 72.0

var _player_near: bool = false
var _prompt: Label


func _ready() -> void:
	_build_marker()
	_build_interact_area()
	_build_prompt()


func _unhandled_input(event: InputEvent) -> void:
	if not _player_near or UiState.is_blocking():
		return
	if event.is_action_pressed("interact"):
		_on_interact()
		get_viewport().set_input_as_handled()


func _build_marker() -> void:
	var base := ColorRect.new()
	base.position = Vector2(-32, -24)
	base.size = Vector2(64, 48)
	base.color = Color(0.22, 0.28, 0.36, 1)
	base.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(base)

	var screen := ColorRect.new()
	screen.position = Vector2(-26, -20)
	screen.size = Vector2(52, 32)
	screen.color = Color(0.35, 0.55, 0.75, 1)
	screen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(screen)

	var tag := Label.new()
	tag.text = zone_label
	tag.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	tag.position = Vector2(-54, 26)
	tag.size = Vector2(108, 18)
	tag.add_theme_font_size_override("font_size", 11)
	tag.add_theme_color_override("font_color", Color(0.85, 0.9, 1, 1))
	tag.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(tag)


func _build_interact_area() -> void:
	var area := Area2D.new()
	area.collision_mask = 1
	add_child(area)

	var shape_node := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = interact_radius
	shape_node.shape = circle
	area.add_child(shape_node)

	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)


func _build_prompt() -> void:
	_prompt = Label.new()
	_prompt.text = "[E] Open example" if open_mode == OpenMode.OPEN_EXAMPLE else "[E] Open folder"
	_prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_prompt.position = Vector2(-56, -52)
	_prompt.add_theme_font_size_override("font_size", 14)
	_prompt.add_theme_color_override("font_color", Color(0.7, 0.95, 1, 1))
	_prompt.visible = false
	_prompt.z_index = 2
	add_child(_prompt)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player_near = true
		_prompt.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player_near = false
		_prompt.visible = false


func _on_interact() -> void:
	if HttpPopupUI.instance == null:
		return
	if open_mode == OpenMode.OPEN_EXAMPLE:
		HttpPopupUI.instance.open_example_file(http_file_path)
	else:
		HttpPopupUI.instance.open_folder_in_browser(folder_path)
