extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Camera2D.make_current()
	_on_Sun_time_change()
	$Area.connect("interacting", self, "on_interaction", [$Area])
	$Player.connect("item_added", self, "player_item_added")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input()

# universal input
func get_input():
	if Input.is_action_just_pressed('ui_cancel'):
		$HUD.close()

func _on_Sun_time_change():
	var time = $Sun.time
	var ticks = $Sun.TICKS
	$HUD.update_time_label(time, ticks)


# whenever the sun injures a player
func _on_Sun_sun_damage():
	$Player.lose_health(1)

# whenever something is interacted with
func on_interaction(object):
	var action_dict = object.on_interaction()
	if action_dict["to_display"]:
		$HUD.display_info(action_dict["info"])

func player_item_added(item, item_num, num_added):
	$HUD/WoodLabel.text = item + ": " + str(item_num) + " (" + str(num_added) + " added)"






