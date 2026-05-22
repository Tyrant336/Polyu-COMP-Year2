extends Node2D

## Decorative floor zones (no collision — player walks through everything).

const OFFICE_SIZE := Vector2(560, 400)
const WORK_AREA_SIZE := Vector2(440, 360)
const ZONE_GAP := 48.0
const WALL_THICKNESS := 10.0
const NPC_SCALE := 3.0

# Colors
const COLOR_HALL := Color(0.42, 0.52, 0.46, 1)
const COLOR_OFFICE_FLOOR := Color(0.82, 0.78, 0.72, 1)
const COLOR_WORK_FLOOR := Color(0.78, 0.82, 0.88, 1)
const COLOR_WALL := Color(0.38, 0.35, 0.32, 1)
const COLOR_CARPET := Color(0.76, 0.72, 0.66, 1)
const COLOR_WORK_MAT := Color(0.68, 0.72, 0.78, 1)
const COLOR_DESK := Color(0.52, 0.38, 0.26, 1)
const COLOR_TABLE := Color(0.45, 0.32, 0.22, 1)
const COLOR_MONITOR := Color(0.22, 0.24, 0.28, 1)
const COLOR_SHELF := Color(0.48, 0.44, 0.40, 1)
const COLOR_LABEL_BG := Color(0.32, 0.55, 0.38, 0.85)
const COLOR_WORK_LABEL_BG := Color(0.28, 0.45, 0.62, 0.9)


func _ready() -> void:
	_build_hallway()
	var office := _build_office(Vector2.ZERO)
	var work_center := _work_area_center()
	var work := _build_working_area(work_center)
	_build_connector(office, work_center)
	_build_npcs(office)
	_build_office_computer(office)
	_build_work_area_npc(work)
	_build_http_terminal(work)
	_place_player_at_work_area(work)


func _build_hallway() -> void:
	var hall := Node2D.new()
	hall.name = "Hallway"
	add_child(hall)

	_box(hall, Rect2(-72, 200, 144, 160), COLOR_HALL)
	_plaque(hall, "Hall", Vector2(0, 276), 18)


func _build_office(center: Vector2) -> Node2D:
	var office := Node2D.new()
	office.name = "Office"
	office.position = center
	add_child(office)

	var half := OFFICE_SIZE * 0.5
	var top_left := -half

	_box(office, Rect2(top_left, OFFICE_SIZE), COLOR_OFFICE_FLOOR)

	_box(office, Rect2(top_left.x, top_left.y, OFFICE_SIZE.x, WALL_THICKNESS), COLOR_WALL)
	_box(
		office,
		Rect2(top_left.x, top_left.y + OFFICE_SIZE.y - WALL_THICKNESS, OFFICE_SIZE.x, WALL_THICKNESS),
		COLOR_WALL
	)
	_box(office, Rect2(top_left.x, top_left.y, WALL_THICKNESS, OFFICE_SIZE.y), COLOR_WALL)
	_box(
		office,
		Rect2(top_left.x + OFFICE_SIZE.x - WALL_THICKNESS, top_left.y, WALL_THICKNESS, OFFICE_SIZE.y),
		COLOR_WALL
	)

	_box(office, Rect2(-100, 104, 200, 72), COLOR_CARPET)

	_box(office, Rect2(-236, -144, 88, 56), COLOR_DESK)
	_box(office, Rect2(148, -144, 88, 56), COLOR_DESK)
	_box(office, Rect2(-236, 40, 88, 56), COLOR_DESK)
	_box(office, Rect2(148, 40, 88, 56), COLOR_DESK)

	_box(office, Rect2(-72, -116, 144, 72), COLOR_TABLE)

	_plaque(office, "Office", Vector2(0, -156), 26)
	return office


func _work_area_center() -> Vector2:
	return Vector2(
		OFFICE_SIZE.x * 0.5 + ZONE_GAP + WORK_AREA_SIZE.x * 0.5,
		0.0
	)


func _build_connector(_office: Node2D, work_center: Vector2) -> void:
	var passage := Node2D.new()
	passage.name = "Connector"
	add_child(passage)

	var office_right := OFFICE_SIZE.x * 0.5
	var work_left := work_center.x - WORK_AREA_SIZE.x * 0.5
	var width := work_left - office_right
	var height := 56.0

	_box(
		passage,
		Rect2(office_right, -height * 0.5, width, height),
		COLOR_WORK_MAT
	)


func _build_working_area(center: Vector2) -> Node2D:
	var work := Node2D.new()
	work.name = "WorkingArea"
	work.position = center
	add_child(work)

	var half := WORK_AREA_SIZE * 0.5
	var top_left := -half

	_box(work, Rect2(top_left, WORK_AREA_SIZE), COLOR_WORK_FLOOR)

	_box(work, Rect2(top_left.x, top_left.y, WORK_AREA_SIZE.x, WALL_THICKNESS), COLOR_WALL)
	_box(
		work,
		Rect2(top_left.x, top_left.y + WORK_AREA_SIZE.y - WALL_THICKNESS, WORK_AREA_SIZE.x, WALL_THICKNESS),
		COLOR_WALL
	)
	_box(work, Rect2(top_left.x, top_left.y, WALL_THICKNESS, WORK_AREA_SIZE.y), COLOR_WALL)
	_box(
		work,
		Rect2(top_left.x + WORK_AREA_SIZE.x - WALL_THICKNESS, top_left.y, WALL_THICKNESS, WORK_AREA_SIZE.y),
		COLOR_WALL
	)

	# Chair / work mat in front of desk
	_box(work, Rect2(-36, 48, 72, 72), COLOR_WORK_MAT)

	# Main desk (yours)
	_box(work, Rect2(-70, -20, 140, 64), COLOR_DESK)
	_box(work, Rect2(-22, -52, 44, 32), COLOR_MONITOR)

	# Side shelf & small filing corner
	_box(work, Rect2(150, -120, 56, 120), COLOR_SHELF)
	_box(work, Rect2(-170, 100, 80, 48), COLOR_SHELF)

	_plaque(work, "Working Area", Vector2(0, -140), 26, COLOR_WORK_LABEL_BG)
	_plaque(work, "My Desk", Vector2(0, 10), 18, COLOR_WORK_LABEL_BG)
	return work


func _build_office_computer(office: Node2D) -> void:
	var pc := Node2D.new()
	pc.set_script(load("res://scripts/http_interact_zone.gd"))
	pc.position = Vector2(120, -30)
	pc.set("zone_label", "Computer")
	pc.set("open_mode", 1)
	pc.set("http_file_path", "res://example.http")
	office.add_child(pc)


func _build_work_area_npc(work: Node2D) -> void:
	var npcs := Node2D.new()
	npcs.name = "NPCs"
	work.add_child(npcs)

	# Colleague beside your desk (walkable, press E to talk).
	var colleague := Node2D.new()
	colleague.set_script(load("res://scripts/talkable_npc.gd"))
	colleague.position = Vector2(105, 55)
	colleague.set("npc_name", "Alex")
	colleague.set(
		"lines",
		PackedStringArray([
			"Morning! You're at your desk early.",
			"I put the new files on the shelf behind you.",
			"Press E anytime if you want to chat.",
		])
	)
	colleague.set("facing", CharacterSheet.Facing.RIGHT)
	colleague.set("flip_h", true)
	npcs.add_child(colleague)


func _build_http_terminal(work: Node2D) -> void:
	var terminal := Node2D.new()
	terminal.set_script(load("res://scripts/http_interact_zone.gd"))
	terminal.position = Vector2(-120, -95)
	terminal.set("zone_label", "HTTP Terminal")
	terminal.set("open_mode", 0)
	terminal.set("folder_path", ProjectPaths.resolve_exact_folder())
	work.add_child(terminal)
	# Walkable — no collision on the terminal marker.


func _place_player_at_work_area(work: Node2D) -> void:
	var player := get_parent().get_node_or_null("Player") as Node2D
	if player == null:
		return
	player.global_position = work.global_position + Vector2(0, 72)


func _build_npcs(office: Node2D) -> void:
	var npcs := Node2D.new()
	npcs.name = "NPCs"
	office.add_child(npcs)

	# Reception — facing visitor (down)
	_add_npc(npcs, Vector2(0, 130), CharacterSheet.Facing.DOWN)

	# Desks — face toward desk / wall
	_add_npc(npcs, Vector2(-195, -115), CharacterSheet.Facing.DOWN)
	_add_npc(npcs, Vector2(195, -115), CharacterSheet.Facing.DOWN)
	_add_npc(npcs, Vector2(-195, 55), CharacterSheet.Facing.UP)
	_add_npc(npcs, Vector2(195, 55), CharacterSheet.Facing.UP)

	# Meeting table — facing table
	_add_npc(npcs, Vector2(-50, -95), CharacterSheet.Facing.RIGHT)
	_add_npc(npcs, Vector2(50, -95), CharacterSheet.Facing.RIGHT, true)
	_add_npc(npcs, Vector2(0, -70), CharacterSheet.Facing.DOWN)

	# Hall — one NPC near entrance
	var hall := get_node_or_null("Hallway")
	if hall:
		_add_npc(hall, Vector2(0, 230), CharacterSheet.Facing.UP)


func _add_npc(
	parent: Node2D,
	pos: Vector2,
	facing: CharacterSheet.Facing,
	flip_h: bool = false,
	frame_col: int = 0
) -> void:
	var npc := Node2D.new()
	npc.position = pos
	parent.add_child(npc)

	var sprite := CharacterSheet.create_still_sprite(facing, frame_col, NPC_SCALE, flip_h)
	npc.add_child(sprite)


func _box(parent: Node2D, rect: Rect2, color: Color) -> ColorRect:
	var box := ColorRect.new()
	box.position = rect.position
	box.size = rect.size
	box.color = color
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(box)
	return box


func _plaque(
	parent: Node2D,
	text: String,
	center: Vector2,
	font_size: int,
	label_color: Color = COLOR_LABEL_BG
) -> void:
	var size := Vector2(maxf(72.0, text.length() * (font_size * 0.5) + 24.0), font_size + 14.0)
	var pos := center - size * 0.5

	var bg := ColorRect.new()
	bg.position = pos
	bg.size = size
	bg.color = label_color
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(bg)

	var label := Label.new()
	label.text = text
	label.position = pos
	label.size = size
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", Color(1, 1, 1, 1))
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(label)
