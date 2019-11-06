extends Node2D

export (PackedScene) var Resource

signal interacting

var screen_size
var current_interactable

# Called when the node enters the scene resource for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$NPC.connect("interacting", self, "interaction", [$NPC])
	generate_obstacles()

func generate_obstacles():
	var rng = RandomNumberGenerator.new()
	for i in range(2048):
		rng.randomize()
		var x = rng.randi_range(0, 512) * 32
		rng.randomize()
		var y = rng.randi_range(0, 256) * 32
		var resource = Resource.instance()
		add_child(resource)
		resource.position = Vector2(x, y)
		rng.randomize()
		resource.type = rng.randi_range(0, 2)
		resource.update_resource()
		resource.connect("interacting", self, "interaction", [resource])
	
	
# called when an interaction is detected
func interaction(interactable):
	current_interactable = interactable
	emit_signal("interacting")

# called by parent node to act on interaction
func on_interaction():
	return current_interactable.on_interaction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



## surround the scene in resources
#	var generation_pos = Vector2(32, 32)
#	while generation_pos.x < screen_size.x:
#		# one resource spawns at the top, one at the bottom
#		var resource = Resource.instance()
#		var bottom_resource = Resource.instance()
#		add_child(resource)
#		add_child(bottom_resource)
#		resource.position = generation_pos
#		bottom_resource.position = Vector2(generation_pos.x, generation_pos.y + screen_size.y - 64)
#		resource.connect("interacting", self, "interaction", [resource])
#		bottom_resource.connect("interacting", self, "interaction", [bottom_resource])
#
#		# generate a column at the current x position if it is either side of the screen
#		if generation_pos.x == 32 or generation_pos.x >= (screen_size.x - 64):
#			generation_pos.y += 64
#			while generation_pos.y < screen_size.y:
#				var resource2 = Resource.instance()
#				add_child(resource2)
#				resource2.position = generation_pos
#				resource2.connect("interacting", self, "interaction", [resource2])
#				generation_pos.y += 64
#			generation_pos.y = 32
#
#		generation_pos.x += 64
##