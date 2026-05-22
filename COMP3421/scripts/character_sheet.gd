class_name CharacterSheet
extends RefCounted

## Single-frame sprites from the walk sheet (5 rows x 4 columns, 24x24 each).

const FRAME_SIZE := Vector2i(24, 24)
const TEXTURE := preload("res://16x16 Walk-Sheet.png")

enum Facing {
	DOWN,
	DOWN_RIGHT,
	RIGHT,
	UP_RIGHT,
	UP,
}


static func create_still_sprite(
	facing: Facing,
	frame_col: int = 0,
	scale: float = 3.0,
	flip_h: bool = false
) -> Sprite2D:
	var sprite := Sprite2D.new()
	var atlas := AtlasTexture.new()
	atlas.atlas = TEXTURE
	atlas.region = Rect2(
		frame_col * FRAME_SIZE.x,
		int(facing) * FRAME_SIZE.y,
		FRAME_SIZE.x,
		FRAME_SIZE.y
	)
	sprite.texture = atlas
	sprite.scale = Vector2(scale, scale)
	sprite.flip_h = flip_h
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	return sprite
