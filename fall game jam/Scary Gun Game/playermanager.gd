#playermanager.gd
extends Node2D

@export var inv: Inv

var score = 0
var lives = 100
var combo = 0
var hp_bonus = 0
var level = 0


func _ready():
	$ScoreLabel.text = "Tickets: %d" % score
	#$ScoreLabel.text = "Tickets: %d" % score
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
	
func set_level(x):
	level = x

func go_to_level(x):
	if level == 0:
		get_tree().change_scene_to_file("res://ui/Main Menu.tscn")
	if level == 1:
		get_tree().change_scene_to_file("res://testingground.tscn")
	if level == 2:
		get_tree().change_scene_to_file("res://shop.tscn")
	if level == 3:
		get_tree().change_scene_to_file("res://round2.tscn")
	if level == 4:
		get_tree().change_scene_to_file("res://shop.tscn")
	if level == 5:
		get_tree().change_scene_to_file("res://round3.tscn")
	
	
