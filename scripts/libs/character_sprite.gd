extends Sprite2D
class_name CharacterSprite

enum BODIES_TYPE {
	Body1,
	Body2,
	Body3,
	Body4,
	Body5,
	Body6,
	Body7,
	Body8
}

enum HAIRS_TYPE {
	Bob,
	Braids,
	Buzzcut,
	Curly,
	Emo,
	ExtraLong,
	ExtraLongSkirt,
	FrenchCurl,
}

enum CLOTHES_TYPE {
	BaseShirt,
	FloraShirt,
	SportYShirt,
	SailorShirt,
	SailorBowShirt,
	SkullShirt,
	StripeShirt,
	Overalls,
	Suit,
	Spaghetti
}

enum PANTS_TYPE {
	Pants,
	PantsSuit,
	Dress,
	Skirt
}

enum SHOES_TYPE {
	Shoes
}

const BODY_VARIANTS: int = 8

const BODIES: Texture2D = preload("res://assets/textures/characters/bodies/char_all.png")
const CLOTHES: Texture2D = preload("res://assets/textures/characters/clothes/basic.png")
const PANTS: Texture2D = preload("res://assets/textures/characters/clothes/pants.png")
const SHOES: Texture2D = preload("res://assets/textures/characters/clothes/shoes.png")
const EYES: Texture2D = preload("res://assets/textures/characters/eyes/eyes.png")
const HAIRS: Texture2D = preload("res://assets/textures/characters/hair/bob.png")

const SPRITE_SHEET_WIDTH: int = 256
const SPRITE_SHEET_HEIGHT: int = 1568
const SPRITE_SHEET_SIZE: Vector2i = Vector2i(SPRITE_SHEET_WIDTH, SPRITE_SHEET_HEIGHT)

func set_appearance(body: int, clothes: int, pants: int, shoes: int, eyes: int, hair: int) -> void:
	var composited: Image = Image.create_empty(SPRITE_SHEET_WIDTH, SPRITE_SHEET_HEIGHT, false, Image.FORMAT_RGBA8)
	
	_blend_layer(composited, BODIES.get_image(), body)
	_blend_layer(composited, CLOTHES.get_image(), clothes)
	_blend_layer(composited, PANTS.get_image(), pants)
	_blend_layer(composited, SHOES.get_image(), shoes)
	_blend_layer(composited, EYES.get_image(), eyes)
	_blend_layer(composited, HAIRS.get_image(), hair)
	
	texture = ImageTexture.create_from_image(composited)
	
func randomize_appearance() -> void:
	pass
	
func _blend_layer(target_image: Image, layer: Image, variant: int) -> void :
	var size: Rect2i = Rect2i(Vector2i(SPRITE_SHEET_WIDTH * variant, 0), SPRITE_SHEET_SIZE)
	target_image.blend_rect(layer, size, Vector2i.ZERO)
