#testingground.gd
extends Node2D

var heights = [100, 175, 250, 325, 400]
var speed = 200  # enemy speed

func _on_timer_timeout():
	var screen_width = get_viewport_rect().size.x
	var bad_guy_scene = preload("res://badguy.tscn")
	var bad_guy = bad_guy_scene.instantiate()

	# Pick a random spawn row
	var random_height = heights[randi() % heights.size()]
	
	# Randomly assign a movement type
	var movement_type = randi() % 4  # 0 to 3
	bad_guy.set("movement_type", movement_type)

	# Assign position and direction based on movement type
	match movement_type:
		0:  # Left to right
			bad_guy.position = Vector2(0, random_height)
			bad_guy.set("speed", speed)
		1:  # Right to left
			bad_guy.position = Vector2(screen_width, random_height)
			bad_guy.set("speed", -speed)
		2:  # Left to middle, then turn around to the right
			bad_guy.position = Vector2(0, random_height)
			bad_guy.set("speed", speed)
		3:  # Right to middle, then turn around to the left
			bad_guy.position = Vector2(screen_width, random_height)
			bad_guy.set("speed", -speed)

	add_child(bad_guy)
	print("Bad guy spawned at: %s with movement type %d" % [bad_guy.position, movement_type])
