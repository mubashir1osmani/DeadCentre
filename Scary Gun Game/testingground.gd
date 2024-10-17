#testingground.gd
extends Node2D

func _on_timer_timeout():
	var screen_width = get_viewport_rect().size.x
	var screen_height = get_viewport_rect().size.y
	var bad_guy_scene = preload("res://badguy.tscn")
	var bad_guy = bad_guy_scene.instantiate()
	bad_guy.position = Vector2(randf_range(0, screen_width), randf_range(0, screen_height))
	add_child(bad_guy)
	print("Bad guy spawned at: %s" % bad_guy.position)
