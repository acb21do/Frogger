extends Area2D

var speed : float
var num_of_turtles : int
var diving_turtle : bool = false
var current_frame : int
var current_frame_progress : float
var dived : bool = false
var count : int =0

@onready var r_turtle_animated_sprite = load("res://Resources/turtle.tres")


func _ready() -> void:
	var turtle_pos : Array[Vector2]
	if num_of_turtles == 2:
		$VisibleOnScreenNotifier2D.position = Vector2(8,0)
		turtle_pos = [Vector2(-8,0), Vector2(8,0)]
	else:
		$VisibleOnScreenNotifier2D.position = Vector2(16,0)
		turtle_pos = [Vector2(-16,0), Vector2(0,0), Vector2(16,0)]

	for i in range(num_of_turtles):
			var turtle_sprite : AnimatedSprite2D = AnimatedSprite2D.new()
			turtle_sprite.sprite_frames = r_turtle_animated_sprite
			turtle_sprite.position = turtle_pos[i]
			if diving_turtle:
				turtle_sprite.play("submerge")
				if i == 0:
					turtle_sprite.animation_finished.connect(change_anim.bind(turtle_sprite))
			else:
				turtle_sprite.play("swim")
				turtle_sprite.set_frame_and_progress(current_frame, current_frame_progress)
			add_child(turtle_sprite)


func get_frame() -> int:
	return get_child(-1).get_frame()


func get_frame_progress() -> float:
	return get_child(-1).get_frame_progress()


func _physics_process(delta) -> void:
	position.x += speed * delta


func change_anim(animated_sprite: AnimatedSprite2D) -> void:
	if dived:
		for i in range(num_of_turtles):
			get_child(-1*(1 + i)).play()
#		animated_sprite.play()
		dived = false
	else:
		for i in range(num_of_turtles):
			get_child(-1*(1 + i)).play_backwards()
		#animated_sprite.play_backwards()
		dived = true
	count += 1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

