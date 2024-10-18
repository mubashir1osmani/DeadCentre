#playermanager.gd
extends Node2D

var score = 0
var lives = 100
var combo = 0
var hp_bonus

func _ready():
	$ScoreLabel.text = "Tickets: %d" % score
	$LivesLabel.text = "Sanity: %d" % lives

func add_points(points):
	score += points
	$ScoreLabel.text = "Tickets: %d" % score

func change_lives(lives_mod):
	lives += lives_mod
	if lives > 100:
		lives = 100
	$LivesLabel.text = "Sanity: %d" % lives

func change_combo(combo_mod):
	combo += combo_mod
	
	if combo > 19:
		hp_bonus = 3
	elif combo > 9:
		hp_bonus = 2
	elif combo > 4:
		hp_bonus = 1
	else:
		hp_bonus = 0
		
	lives += hp_bonus
	if lives > 100:
		lives = 100
	
	$LivesLabel.text = "Sanity: %d" % lives
	$ComboLabel.text = "Combo: %d" % combo

func drop_combo():
	combo = 0
	$ComboLabel.text = "Combo: %d" % combo
