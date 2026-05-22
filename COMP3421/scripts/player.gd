extends CharacterBody2D

@export var speed: float = 120.0
@export var walk_fps: float = 6.0
@export var sprite_scale: float = 3.0

const FRAME_SIZE := Vector2i(24, 24)
const BASE_COLLISION_SIZE := Vector2(14, 10)
const BASE_COLLISION_OFFSET_Y := 8.0
const WALK_TEXTURE := preload("res://16x16 Walk-Sheet.png")

const ANIM_DOWN := "walk_down"
const ANIM_DOWN_RIGHT := "walk_down_right"
const ANIM_RIGHT := "walk_right"
const ANIM_UP_RIGHT := "walk_up_right"
const ANIM_UP := "walk_up"

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _collision: CollisionShape2D = $PlayerCollision

var _last_anim: String = ANIM_DOWN
var _movement_enabled: bool = true


func _ready() -> void:
	add_to_group("player")
	motion_mode = MOTION_MODE_FLOATING
	_apply_sprite_scale()
	_setup_walk_animations()


func set_movement_enabled(enabled: bool) -> void:
	_movement_enabled = enabled
	if not enabled:
		velocity = Vector2.ZERO
		_sprite.stop()
		_sprite.frame = 0


func _apply_sprite_scale() -> void:
	var scale_vec := Vector2(sprite_scale, sprite_scale)
	_sprite.scale = scale_vec

	var shape := _collision.shape as RectangleShape2D
	shape.size = BASE_COLLISION_SIZE * sprite_scale
	_collision.position = Vector2(0.0, BASE_COLLISION_OFFSET_Y * sprite_scale)


func _setup_walk_animations() -> void:
	var sprite_frames := SpriteFrames.new()
	var names := [ANIM_DOWN, ANIM_DOWN_RIGHT, ANIM_RIGHT, ANIM_UP_RIGHT, ANIM_UP]

	for row in range(5):
		var anim_name: String = names[row]
		sprite_frames.add_animation(anim_name)
		sprite_frames.set_animation_loop(anim_name, true)
		sprite_frames.set_animation_speed(anim_name, walk_fps)

		for col in range(4):
			var atlas := AtlasTexture.new()
			atlas.atlas = WALK_TEXTURE
			atlas.region = Rect2(
				col * FRAME_SIZE.x,
				row * FRAME_SIZE.y,
				FRAME_SIZE.x,
				FRAME_SIZE.y
			)
			sprite_frames.add_frame(anim_name, atlas)

	_sprite.sprite_frames = sprite_frames
	_sprite.play(ANIM_DOWN)


func _physics_process(_delta: float) -> void:
	if not _movement_enabled:
		velocity = Vector2.ZERO
		return

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	_update_animation(direction)


func _update_animation(direction: Vector2) -> void:
	if direction.length_squared() < 0.01:
		_sprite.stop()
		_sprite.frame = 0
		return

	var anim: String
	var flip_h := false

	# Sheet rows: 0=down, 1=down-right, 2=right, 3=up-right, 4=up. Flip for left.
	var octant := int(round(direction.angle() / (PI / 4.0)))
	if octant < 0:
		octant += 8
	octant %= 8

	match octant:
		0, 4:
			anim = ANIM_RIGHT
			flip_h = octant == 4
		2:
			anim = ANIM_DOWN
		6:
			anim = ANIM_UP
		1:
			anim = ANIM_DOWN_RIGHT
		3:
			anim = ANIM_DOWN_RIGHT
			flip_h = true
		5:
			anim = ANIM_UP_RIGHT
			flip_h = true
		7:
			anim = ANIM_UP_RIGHT
		_:
			anim = _last_anim

	_sprite.flip_h = flip_h

	if _sprite.animation != anim:
		_sprite.play(anim)
		_last_anim = anim
	elif not _sprite.is_playing():
		_sprite.play(anim)
