#playermanager.gd
extends Node2D

var score = 0
var lives = 100

func _ready():
	$ScoreLabel.text = "Score: %d" % score
	$LivesLabel.text = "Sanity: %d" % lives

func add_points(points):
	score += points
	$ScoreLabel.text = "Score: %d" % score

func change_lives(lives_mod):
	lives += lives_mod
	$LivesLabel.text = "Sanity: %d" % lives

func death():
	if lives == 0:
		get_tree().change_scene_to_file("res://gameover.tscn")
