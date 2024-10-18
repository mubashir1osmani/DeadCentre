extends Node2D


func _on_timer_timeout():
	get_tree().call_group("score", "change_lives", -1)
	var bad_guy_scene = preload("res://badguy.tscn")
	var bad_guy = bad_guy_scene.instantiate()
	add_child(bad_guy)
	print("Bad guy spawned at: %s with movement type %s" % [bad_guy.position, bad_guy.movement_type])
