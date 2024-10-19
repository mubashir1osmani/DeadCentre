#round_2.gd
extends Node2D

var target_pool = []
var current_index = 0

# Function to initialize the target pool
func _ready():
	# Fill the pool with the specified targets
	for _i in range(30):
		target_pool.append("EasyTarget")
	for _i in range(15):
		target_pool.append("MediumTarget")
	for _i in range(10):
		target_pool.append("DangerTarget")
	for _i in range(5):
		target_pool.append("Butterfly")
	target_pool.append("DangerTarget")  # Add the RareTarget

	# Shuffle the pool to randomize the order
	target_pool.shuffle()

func spawn_bad_guy(target_type):
	var bad_guy_scene = preload("res://round2badguy.tscn")
	var bad_guy = bad_guy_scene.instantiate()
	bad_guy.target_type = target_type
	if target_type != "":
		add_child(bad_guy)
	print("Bad guy spawned at: %s with target type %s" % [bad_guy.position, target_type])

func _on_timer_timeout():
	get_tree().call_group("player", "change_lives", -1)
	# Check if the pool is depleted
	if current_index < target_pool.size():
		# Get the next target type from the pool
		var target_type = target_pool[current_index]
		spawn_bad_guy(target_type)
		current_index += 1  # Move to the next target in the pool
	else:
		print("All targets have been spawned!")
