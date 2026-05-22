extends Node2D

@export var npc_name: String = "Colleague"
@export var lines: PackedStringArray = [
	"Hey! Good to see you at your desk.",
	"The office next door is pretty busy today.",
	"Let me know if you need help with anything.",
]
@export var interact_radius: float = 88.0
@export var facing: CharacterSheet.Facing = CharacterSheet.Facing.RIGHT
@export var flip_h: bool = false

var _player_near: bool = false
var _prompt: Label


func _ready() -> void:
	_build_sprite()
	_build_interact_area()
	_build_prompt()


func _unhandled_input(event: InputEvent) -> void:
	if not _player_near or UiState.is_blocking():
		return
	if event.is_action_pressed("interact"):
		_start_talk()
		get_viewport().set_input_as_handled()


func _build_sprite() -> void:
	var sprite := CharacterSheet.create_still_sprite(facing, 0, 3.0, flip_h)
	add_child(sprite)


func _build_interact_area() -> void:
	var area := Area2D.new()
	area.name = "InteractArea"
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
	_prompt.text = "[E] Talk"
	_prompt.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_prompt.position = Vector2(-36, -58)
	_prompt.add_theme_font_size_override("font_size", 14)
	_prompt.add_theme_color_override("font_color", Color(1, 1, 0.85, 1))
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


func _start_talk() -> void:
	if DialogueUI.instance == null:
		return
	DialogueUI.instance.open_dialogue(npc_name, lines)


