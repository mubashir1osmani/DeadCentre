extends Node2D

var heights = [100, 175, 250, 325, 400]  #rows where the enemies can spawn
var speed = 200  #enemy speed

func _on_timer_timeout():
	var screen_width = get_viewport_rect().size.x
	var bad_guy_scene = preload("res://badguy.tscn")
	var bad_guy = bad_guy_scene.instantiate()

	#pick a random spawn row
	var random_height = heights[randi() % heights.size()]
	
	#either move left or ride
	var spawn_side = randi() % 2 == 0
	
	if spawn_side:
		bad_guy.position = Vector2(0, random_height)  #spawn on the left side
		bad_guy.set("speed", speed)  #move right
	else:
		bad_guy.position = Vector2(screen_width, random_height)  #spawn on the right side
		bad_guy.set("speed", -speed)  #move left

	add_child(bad_guy)
	print("Bad guy spawned at: %s" % bad_guy.position)
