extends Area2D

var speed : float
var num_of_logs : int

var log_end_sprite : CompressedTexture2D = preload("res://Asset/LogEnd.png")
var log_mid_sprite : CompressedTexture2D = preload("res://Asset/LogMiddle.png")
var log_start_sprite : CompressedTexture2D = preload("res://Asset/LogStart.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var log_pos : Array[Vector2]
	if num_of_logs == 3:
		$CollisionShape2D.shape.size = Vector2(48,16)
		$VisibleOnScreenNotifier2D.position = Vector2(-16,0)
		log_pos = [Vector2(-16,0), Vector2(0,0), Vector2(16,0)]
	else:
		$CollisionShape2D.shape.size = Vector2(64,16)
		$VisibleOnScreenNotifier2D.position = Vector2(-24,0)
		log_pos = [Vector2(-24,0), Vector2(-8,0), Vector2(8,0), Vector2(24,0)]

	for i in range(num_of_logs):
		var log_sprite : Sprite2D = Sprite2D.new()
		if i == 0:
			log_sprite.texture = log_end_sprite
		elif (i == num_of_logs-1):
			log_sprite.texture = log_start_sprite
		else:
			log_sprite.texture = log_mid_sprite
		log_sprite.position = log_pos[i]
		add_child(log_sprite)


func _physics_process(delta) -> void:
	position.x += speed * delta
