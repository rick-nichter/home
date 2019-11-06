extends StaticBody2D

signal interacting

# the types of resources
enum Types {TREE, ROCK, WATER}

# the type this instance is (default is tree)
var type = Types.TREE

# what to display on interaction
var info

# Called when the node enters the scene tree for the first time.
func _ready():
	update_resource()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# called when the player interacts with this object
func interact():
	emit_signal("interacting")
	match type:
		0:
			return {"add_to_bag": "Wood"}
		1:
			return {"add_to_bag": "Rock"}
		2:
			return {"add_to_bag": "Water"}
	

func on_interaction():
	# chop down tree -> remove from scene
	queue_free()
	return {"info": info, "to_display": true}

# update the resource depending on its type
func update_resource():
	match type:
		0:
			info = "You chop down a tree."
			$Sprite.texture = load("res://bin/pics/16x16 Outdoors Tileset/Outdoors_17.png")
		1:
			info = "You hammer away at a rock."
			$Sprite.texture = load("res://bin/pics/16x16 Outdoors Tileset/Outdoors_34.png")
		2:
			info = "You scoop up some water."
			$Sprite.texture = load("res://bin/pics/16x16 Outdoors Tileset/Outdoors_40.png")
	
	$Sprite.scale.x = 4
	$Sprite.scale.y = 4





