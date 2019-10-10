extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Sun_time_change():
	var time = $Sun.time
	var ticks = $Sun.TICKS
	$HUD.update_time_label(time, ticks)


# whenever the sun injures a player
func _on_Sun_sun_damage():
	$Player.lose_health(1)
