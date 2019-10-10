extends Node2D

export (PackedScene) var Tree

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	generate_obstacles()

func generate_obstacles():
	
	# surround the scene in trees
	var generation_pos = Vector2(32, 32)
	while generation_pos.x < screen_size.x:
		# one tree spawns at the top, one at the bottom
		var tree = Tree.instance()
		var bottom_tree = Tree.instance()
		add_child(tree)
		add_child(bottom_tree)
		tree.position = generation_pos
		bottom_tree.position = Vector2(generation_pos.x, generation_pos.y + screen_size.y - 64)
		
		# generate a column at the current x position if it is either side of the screen
		if generation_pos.x == 32 or generation_pos.x >= (screen_size.x - 64):
			generation_pos.y += 64
			while generation_pos.y < screen_size.y:
				var tree2 = Tree.instance()
				add_child(tree2)
				tree2.position = generation_pos
				generation_pos.y += 64
			generation_pos.y = 32
		 
		generation_pos.x += 64

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass