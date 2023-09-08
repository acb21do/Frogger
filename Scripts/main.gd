extends Node

@onready var car_scene : PackedScene = preload("res://Scenes/car.tscn")
@onready var truck_scene : PackedScene = preload("res://Scenes/truck.tscn")
@onready var turtle_scene : PackedScene = preload("res://Scenes/turtle.tscn")
@onready var log_scene : PackedScene = preload("res://Scenes/log.tscn")
@onready var car_spawner_scene : PackedScene = preload("res://Scenes/car_spawner.tscn")


@onready var player = $Player




var car1_spawner : CarSpawner
var car2_spawner : CarSpawner
var car3_spawner : CarSpawner
var car4_spawner : CarSpawner
var car5_spawner : CarSpawner

var turtle1_spawner : CarSpawner
var log1_spawner : CarSpawner


var current_level : int = 0
#Level variables
var car1_separation_distance : Array[float] = [3.5, 3.5, 3.0, 3.5, 2.5]
var car1_start_pos : Array[Vector2] = [Vector2(88, 216), Vector2(16, 216), Vector2(40, 216), Vector2(16, 216), Vector2(8, 216)]
var car1_num_of_cars : Array[int] = [3, 4, 4, 4, 5]
var car1_car_scene : PackedScene = car_scene #Static
var car1_car_speed : Array[float] = [5.0/8.0, 5.0/8.0, 5.0/2.5, 5.0/2.5, 5.0/2.5]
var car1_direction : int = -1 #Static
var car1_set_distance : Array[float] = [6.0, 1.5, 3.0, 1.5, 1.0]

var car2_separation_distance : Array[float] = [3.0, 3.0, 3.5, 2.5, 3.0]
var car2_start_pos : Array[Vector2] = [Vector2(232, 200), Vector2(168, 200), Vector2(160, 200), Vector2(232,200), Vector2(168,200)]
var car2_num_of_cars : Array[int] = [3, 4, 3, 4, 4]
var car2_car_scene : PackedScene = car_scene #Static
var car2_car_speed : Array[float] = [5.0/6.5, 5.0/6.5, 5.0/4.0, 5.0/4.0, 5.0/4.0]
var car2_direction : int = 1 #Static
var car2_set_distance : Array[float] = [7.0, 3.0, 1.5, 4.5, 3.0]

var car3_separation_distance : Array[float] = [3.0, 3.5, 2.5, 3.5, 2.0]
var car3_start_pos : Array[Vector2] = [Vector2(104,184), Vector2(16,184), Vector2(8,184), Vector2(16,184), Vector2(40,184)]
var car3_num_of_cars : Array[int] = [3, 4, 5, 4, 5]
var car3_car_scene : PackedScene = car_scene #Static
var car3_car_speed : Array[float] = [5.0/5.5, 5.0/5.5, 5.0/2.5, 5.0/2.5, 5.0/2.5]
var car3_direction : int = -1 #Static
var car3_set_distance : Array[float] = [7.0, 1.5, 1.0, 1.5, 3.0]

var car4_separation_distance : Array[float] = [15.0, 1.5, 3.5, 3.0, 2.5]
var car4_start_pos : Array[Vector2] = [Vector2(-24,168), Vector2(232,168), Vector2(232,168), Vector2(232,168), Vector2(240,168)]
var car4_num_of_cars : Array[int] = [4, 2, 2, 3, 4]
var car4_car_scene : PackedScene = car_scene #Static
var car4_car_speed : Array[float] = [5.0/4.0, 5.0/4.0, 10.0/1.375, 10.0/1.375, 10.0/1.375]
var car4_direction : int = 1 #Static
var car4_set_distance : Array[float] = [15.0, 12.5, 10.5, 7.0, 4.5]

var car5_separation_distance : Array[float] = [3.5, 3.5, 2.5, 2.0, 1.5]
var car5_start_pos : Array[Vector2] = [Vector2(136,152), Vector2(48,152), Vector2(80,152), Vector2(32,152), Vector2(112,152)]
var car5_num_of_cars : Array[int] = [2, 4, 3, 4, 3]
var car5_car_scene : PackedScene = truck_scene #Static
var car5_car_speed : Array[float] = [5.0/2.5, 5.0/2.5, 5.0/4.0, 5.0/4.0, 5.0/4.0]
var car5_direction : int = -1 #Static
var car5_set_distance : Array[float] = [8.5, 3.5, 5.0, 2.0, 7.0]

#Turtle 1
#Turtle lvl1 start pos (8,120)
#Turtle lvl2 start pos (8,120)
#Turtle lvl3 start pos (56,120)
#Turtle lvl4 start pos (40,120)
#Turtle lvl5 start pos (96,120)

#216,104

var turtle1_separation_distance : Array[float] = [1.0, 3.0, 1.5, 2.0, 3.5]
var turtle1_start_pos : Array[Vector2] = [Vector2(8,120), Vector2(8,120), Vector2(56,120), Vector2(40,120), Vector2(96,120)]
var turtle1_num_of_cars : Array[int] = [4, 3, 3, 3, 2]
var turtle1_car_scene : PackedScene = turtle_scene #Static
var turtle1_car_speed : Array[float] = [5.0/2.7, 5.0/2.7, 5.0/1.25, 5.0/1.25, 5.0/1.25]
var turtle1_direction : int = -1 #Static
var turtle1_set_distance : Array[float] = [1.0, 1.0, 4.0, 3.0, 6.5]

var log1_separation_distance : Array[float] = [2.0, 3.0, 1.5, 2.0, 3.5]
var log1_start_pos : Array[Vector2] = [Vector2(216,104), Vector2(8,120), Vector2(56,120), Vector2(40,120), Vector2(96,120)]
var log1_num_of_cars : Array[int] = [3, 3, 3, 3, 2]
var log1_car_scene : PackedScene = log_scene #Static
var log1_car_speed : Array[float] = [5.0/6.5, 5.0/2.7, 5.0/1.25, 5.0/1.25, 5.0/1.25]
var log1_direction : int = 1 #Static
var log1_set_distance : Array[float] = [3.0, 1.0, 4.0, 3.0, 6.5]

func _ready() -> void:
	#player.dead.connect()
	start_level()
	
	


func next_level() -> void:
	for car_spawner in $CarSpawners.get_children():
		car_spawner.queue_free()
	for turtle_spawner in $TurtleSpawners.get_children():
		turtle_spawner.queue_free()
	for log_spawner in $LogSpawners.get_children():
		log_spawner.queue_free()
		
	current_level = (current_level + 1) % 5
	if current_level == 2:
		car1_car_speed = [5.0/2.5, 5.0/2.5, 5.0/2.5, 5.0/2.5, 5.0/2.5]
		car2_car_speed = [5.0/4.0, 5.0/4.0, 5.0/4.0, 5.0/4.0, 5.0/4.0]
		car3_car_speed = [5.0/2.5, 5.0/2.5, 5.0/2.5, 5.0/2.5, 5.0/2.5]
		car4_car_speed = [10.0/1.375, 10.0/1.375, 10.0/1.375, 10.0/1.375, 10.0/1.375]
		car5_car_speed = [5.0/4.0, 5.0/4.0, 5.0/4.0, 5.0/4.0, 5.0/4.0]
		turtle1_car_speed = [5.0/1.25, 5.0/1.25, 5.0/1.25, 5.0/1.25, 5.0/1.25]
		log1_car_speed = [5.0/1.25, 5.0/1.25, 5.0/1.25, 5.0/1.25, 5.0/1.25]
	start_level()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		next_level()

func start_level() -> void:
	#Car 1
	car1_spawner = car_spawner_scene.instantiate()
	car1_spawner.separation_distance = car1_separation_distance[current_level]
	car1_spawner.start_pos = car1_start_pos[current_level]
	car1_spawner.num_of_cars = car1_num_of_cars[current_level]
	car1_spawner.car_scene = car_scene #Static
	car1_spawner.car_speed = car1_car_speed[current_level]
	car1_spawner.direction = -1# Static
	car1_spawner.set_distance = car1_set_distance[current_level]
	car1_spawner.car_type = "1"# Static
	$CarSpawners.add_child(car1_spawner)
	car1_spawner.spawn_cars()
	#Car 2
	car2_spawner = car_spawner_scene.instantiate()
	car2_spawner.separation_distance = car2_separation_distance[current_level]
	car2_spawner.start_pos = car2_start_pos[current_level]
	car2_spawner.num_of_cars = car2_num_of_cars[current_level]
	car2_spawner.car_scene = car_scene #Static
	car2_spawner.car_speed = car2_car_speed[current_level]
	car2_spawner.direction = 1# Static
	car2_spawner.set_distance = car2_set_distance[current_level]
	car2_spawner.car_type = "2"# Static
	$CarSpawners.add_child(car2_spawner)
	car2_spawner.spawn_cars()
	#Car 3
	car3_spawner = car_spawner_scene.instantiate()
	car3_spawner.separation_distance = car3_separation_distance[current_level]
	car3_spawner.start_pos = car3_start_pos[current_level]
	car3_spawner.num_of_cars = car3_num_of_cars[current_level]
	car3_spawner.car_scene = car_scene #Static
	car3_spawner.car_speed = car3_car_speed[current_level]
	car3_spawner.direction = -1# Static
	car3_spawner.set_distance = car3_set_distance[current_level]
	car3_spawner.car_type = "3"# Static
	$CarSpawners.add_child(car3_spawner)
	car3_spawner.spawn_cars()
	#Car 4
	car4_spawner = car_spawner_scene.instantiate()
	car4_spawner.separation_distance = car4_separation_distance[current_level]
	car4_spawner.start_pos = car4_start_pos[current_level]
	car4_spawner.num_of_cars = car4_num_of_cars[current_level]
	car4_spawner.car_scene = car_scene #Static
	car4_spawner.car_speed = car4_car_speed[current_level]
	car4_spawner.direction = 1# Static
	car4_spawner.set_distance = car4_set_distance[current_level]
	car4_spawner.car_type = "4"# Static
	$CarSpawners.add_child(car4_spawner)
	car4_spawner.spawn_cars()
	#Car 5
	car5_spawner = car_spawner_scene.instantiate()
	car5_spawner.separation_distance = car5_separation_distance[current_level]
	car5_spawner.start_pos = car5_start_pos[current_level]
	car5_spawner.num_of_cars = car5_num_of_cars[current_level]
	car5_spawner.car_scene = truck_scene #Static
	car5_spawner.car_speed = car5_car_speed[current_level]
	car5_spawner.direction = -1# Static
	car5_spawner.set_distance = car5_set_distance[current_level]
	car5_spawner.car_type = "5"# Static
	car5_spawner.car_width = 32
	$CarSpawners.add_child(car5_spawner)
	car5_spawner.spawn_cars()
	#Turtle 1
	turtle1_spawner = car_spawner_scene.instantiate()
	turtle1_spawner.separation_distance = turtle1_separation_distance[current_level]
	turtle1_spawner.start_pos = turtle1_start_pos[current_level]
	turtle1_spawner.num_of_cars = turtle1_num_of_cars[current_level]
	turtle1_spawner.car_scene = turtle_scene #Static
	turtle1_spawner.car_speed = turtle1_car_speed[current_level]
	turtle1_spawner.direction = -1# Static
	turtle1_spawner.set_distance = turtle1_set_distance[current_level]
	turtle1_spawner.car_width = 16.0 * 3.0
	turtle1_spawner.is_turtle = true
	$TurtleSpawners.add_child(turtle1_spawner)
	turtle1_spawner.spawn_cars()
	#Log 1
	log1_spawner = car_spawner_scene.instantiate()
	log1_spawner.separation_distance = log1_separation_distance[current_level]
	log1_spawner.start_pos = log1_start_pos[current_level]
	log1_spawner.num_of_cars = log1_num_of_cars[current_level]
	log1_spawner.car_scene = log_scene #Static
	log1_spawner.car_speed = log1_car_speed[current_level]
	log1_spawner.direction = 1# Static
	log1_spawner.set_distance = log1_set_distance[current_level]
	log1_spawner.car_width = 16.0 * 3.0
	log1_spawner.is_log = true
	$LogSpawners.add_child(log1_spawner)
	log1_spawner.spawn_cars()
