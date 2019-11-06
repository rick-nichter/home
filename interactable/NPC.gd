extends StaticBody2D

signal interacting

var info = "Hey there! I'm a frog. I'm glad you wanted to talk to me! Unfortunately, I do nothing."

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# called when the player interacts with this object
func interact():
	emit_signal("interacting")
	return {}

# called by parent node when interacted with
func on_interaction():
	# display dialogue
	return {"info": info, "to_display": true}
