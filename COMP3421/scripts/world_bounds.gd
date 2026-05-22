extends Node2D

## Ocean surrounds the island; StaticBody2D walls block the player.

const WORLD_EXTENT := 2000.0
const LAND_HALF := Vector2(920, 500)

const COLOR_OCEAN := Color(0.1, 0.42, 0.68, 1)
const COLOR_OCEAN_DEEP := Color(0.06, 0.32, 0.58, 1)
const COLOR_LAND := Color(0.38, 0.58, 0.45, 1)
const COLOR_BEACH := Color(0.76, 0.7, 0.52, 1)
const BEACH_WIDTH := 32.0


func _ready() -> void:
	_build_ocean()
	_build_beach()
	_build_land()
	_build_ocean_walls()


func _build_ocean() -> void:
	var ocean_root := Node2D.new()
	ocean_root.name = "OceanVisual"
	ocean_root.z_index = -3
	add_child(ocean_root)

	var world_size := WORLD_EXTENT * 2.0
	_box(ocean_root, Rect2(-WORLD_EXTENT, -WORLD_EXTENT, world_size, world_size), COLOR_OCEAN)

	# Deeper strips at the far edges for depth.
	var deep := 320.0
	_box(ocean_root, Rect2(-WORLD_EXTENT, -WORLD_EXTENT, world_size, deep), COLOR_OCEAN_DEEP)
	_box(ocean_root, Rect2(-WORLD_EXTENT, WORLD_EXTENT - deep, world_size, deep), COLOR_OCEAN_DEEP)
	_box(ocean_root, Rect2(-WORLD_EXTENT, -WORLD_EXTENT, deep, world_size), COLOR_OCEAN_DEEP)
	_box(ocean_root, Rect2(WORLD_EXTENT - deep, -WORLD_EXTENT, deep, world_size), COLOR_OCEAN_DEEP)


func _build_beach() -> void:
	var beach := Node2D.new()
	beach.name = "Beach"
	beach.z_index = -2
	add_child(beach)

	var left := -LAND_HALF.x
	var right := LAND_HALF.x
	var top := -LAND_HALF.y
	var bottom := LAND_HALF.y
	var w := LAND_HALF.x * 2.0
	var h := LAND_HALF.y * 2.0
	var b := BEACH_WIDTH

	_box(beach, Rect2(left, top - b, w, b), COLOR_BEACH)
	_box(beach, Rect2(left, bottom, w, b), COLOR_BEACH)
	_box(beach, Rect2(left - b, top - b, b, h + b * 2.0), COLOR_BEACH)
	_box(beach, Rect2(right, top - b, b, h + b * 2.0), COLOR_BEACH)


func _build_land() -> void:
	var land := ColorRect.new()
	land.name = "Land"
	land.z_index = -2
	land.position = -LAND_HALF
	land.size = LAND_HALF * 2.0
	land.color = COLOR_LAND
	land.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(land)


func _build_ocean_walls() -> void:
	var walls := Node2D.new()
	walls.name = "OceanWalls"
	add_child(walls)

	var left := -LAND_HALF.x
	var right := LAND_HALF.x
	var top := -LAND_HALF.y
	var bottom := LAND_HALF.y
	var world := WORLD_EXTENT

	_add_wall(walls, Rect2(-world, -world, world * 2.0, world + top))
	_add_wall(walls, Rect2(-world, bottom, world * 2.0, world - bottom))
	_add_wall(walls, Rect2(-world, top, world + left, bottom - top))
	_add_wall(walls, Rect2(right, top, world - right, bottom - top))


func _add_wall(parent: Node2D, rect: Rect2) -> void:
	var body := StaticBody2D.new()
	body.position = rect.position
	parent.add_child(body)

	var shape_node := CollisionShape2D.new()
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	shape_node.shape = shape
	shape_node.position = rect.size * 0.5
	body.add_child(shape_node)


func _box(parent: Node2D, rect: Rect2, color: Color) -> void:
	var box := ColorRect.new()
	box.position = rect.position
	box.size = rect.size
	box.color = color
	box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	parent.add_child(box)
