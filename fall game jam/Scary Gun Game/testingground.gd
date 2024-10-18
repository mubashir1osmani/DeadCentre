extends Node2D

var heights = [100, 175, 250, 325, 400]
var speed = 200  # enemy speed

func _on_timer_timeout():
	var screen_width = int(get_viewport_rect().size.x)  # Cast screen_width to int
	var screen_height = int(get_viewport_rect().size.y)  # Cast screen_height to int
	var bad_guy_scene = preload("res://badguy.tscn")
	var bad_guy = bad_guy_scene.instantiate()

	# Pick a random spawn row/column
	var random_height = heights[randi() % heights.size()]

	# Assign position based on movement type, which will be decided in badguy.gd
	bad_guy.position = Vector2(0, random_height)

	add_child(bad_guy)
	print("Bad guy spawned at: %s" % [bad_guy.position])
