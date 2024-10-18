extends Node2D

<<<<<<< HEAD
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
=======
var target_pool = []
var current_index = 0

# Function to initialize the target pool
func _ready():
	# Fill the pool with the specified targets
	for _i in range(35):
		target_pool.append("EasyTarget")
	for _i in range(10):
		target_pool.append("MediumTarget")
	for _i in range(5):
		target_pool.append("DangerTarget")
	target_pool.append("RareTarget")  # Add the RareTarget

	# Shuffle the pool to randomize the order
	target_pool.shuffle()

func spawn_bad_guy(target_type):
	var bad_guy_scene = preload("res://badguy.tscn")
	var bad_guy = bad_guy_scene.instantiate()
	bad_guy.target_type = target_type
	add_child(bad_guy)
	print("Bad guy spawned at: %s with target type %s" % [bad_guy.position, target_type])

func _on_timer_timeout():
	# Check if the pool is depleted
	if current_index < target_pool.size():
		# Get the next target type from the pool
		var target_type = target_pool[current_index]
		spawn_bad_guy(target_type)
		current_index += 1  # Move to the next target in the pool
	else:
		print("ROUND 1 CLEAR!")
>>>>>>> refs/remotes/origin/main
