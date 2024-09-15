extends TextureRect

@export var rows: int = 1
@export var cols: int = 9
@export var fps : int = 18

# data variables
var time := 0.0
var sizeAtlas := Vector2()
var currCol := 0

# reference variables
var atlas : AtlasTexture = null

func _ready() -> void:
	time = 1.0/float(fps)
	$Timer.wait_time = time
	$Timer.timeout.connect(nextFrame)
	$Timer.start()
	
	if texture is AtlasTexture:
		atlas = texture
	else:
		printerr("what the fuck")
		return
	
	sizeAtlas = atlas.get_size()

func nextFrame() -> void:
	currCol += sizeAtlas.x # fuck around
	atlas.region.position.x = currCol
	currCol += 1
	
	if currCol > rows:
		currCol = 0
