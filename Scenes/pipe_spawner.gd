extends Node


class_name PipeSpawner

var pipe_pair_scene = preload("res://Scenes/pipe_pair.tscn")
signal bird_crashed
signal point_scored
@export var pipe_speed = -150
@onready var spawn_timer = $SpawnTimer


func _ready():
	spawn_timer.start()
	
	
	
func spawn_pipe():
	var pipe = pipe_pair_scene.instantiate() as PipePair
	add_child(pipe)
	
	var viewpor_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pipe.position.x = viewpor_rect.end.x
	
	
	var half_height = viewpor_rect.size.y /2
	
	pipe.position.y = randf_range(viewpor_rect.size.y * 0.15 - half_height, viewpor_rect.size.y *0.65 -half_height)
	
	
	pipe.point_scored.connect(on_point_scored)
	pipe.bird_entered.connect(on_bird_entered)
	pipe.set_speed(pipe_speed)
	
func start_spawning_pipes():
	spawn_timer.timeout.connect(spawn_pipe)
	


	
func on_point_scored():
	point_scored.emit()
func on_bird_entered():
	bird_crashed.emit()
	stop()
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is PipePair):
		(pipe as PipePair).speed=0
