extends CanvasLayer

var score = 0

func _ready():
	$Label.text = "Score: %d" % score

func add_points(points):
	score += points
	$Label.text = "Score: %d" % score
