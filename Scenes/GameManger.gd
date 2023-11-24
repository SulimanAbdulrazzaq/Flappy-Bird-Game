extends Node

@onready var bird = $"../Bird" as Bird
@onready var ground = $"../Ground" as Ground
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI

var points = 0

func _ready():
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)

func on_game_started():
	pipe_spawner.start_spawning_pipes()
	
func on_point_scored():
	points+=1
	ui.UpdatePoints(points)

func end_game():
	if fade != null:
		fade.play()
	ground.stop()
	bird.kill()
	pipe_spawner.stop()
	ui.on_game_over()
