extends CanvasLayer
class_name UI
@onready var points_label = $MarginContainer/PointsLabel
@onready var game_over_box = $MarginContainer/GameOverBox

# Called when the node enters the scene tree for the first time.
func _ready():
	points_label.text = "%d" %0
	
func UpdatePoints(points: int):
	points_label.text =  "%d" % points
	
func on_game_over():
	game_over_box.visible = true
	

func _on_button_pressed():
	get_tree().reload_current_scene()
