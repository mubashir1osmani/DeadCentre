#score.gd
extends Node2D

var score = 0
var lives = 3

func _ready():
	$ScoreLabel.text = "Score: %d" % score
	$LivesLabel.text = "Lives: %d" % lives

func add_points(points):
	score += points
	$ScoreLabel.text = "Score: %d" % score

func change_lives(lives_mod):
	lives += lives_mod
	$LivesLabel.text = "Lives: %d" % lives
	
