#playermanager.gd
extends Node2D

var score = 0
var lives = 100
var combo = 0

func _ready():
	$ScoreLabel.text = "Tickets: %d" % score
	$LivesLabel.text = "Sanity: %d" % lives

func add_points(points):
	score += points
	$ScoreLabel.text = "Tickets: %d" % score

func change_lives(lives_mod):
	lives += lives_mod
	$LivesLabel.text = "Sanity: %d" % lives
