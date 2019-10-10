extends Light2D

signal time_change
signal sun_damage

# the number of timer ticks in an hour
const TICKS = 60
# starting time is 8:00 PM, or 20:00
var time = 6 * TICKS

# Called when the node enters the scene tree for the first time.
func _ready():
	pass	

func _on_Time_timeout():
	update_time()
	emit_signal("time_change")
	send_sun_damage()

func update_time():
	time += 1
	# if it is 12:00 PM (24:00), start a new day
	if time >= (24 * TICKS):
		time = 0
	
	check_sun_changing()

func check_sun_changing():
	# update the sun every 3 ticks if it between 6 and 8 AM/PM, shifts between add/sub brightness
	
	if time >= 6 * TICKS and time < 6.5 * TICKS and time % 3 == 0:
		energy -= .05
	elif time >= 6.5 * TICKS and time < 8 * TICKS and time % 3 == 0:
		mode = Light2D.MODE_ADD
		energy += .05
	elif time >= 18 * TICKS and time < 19.5 * TICKS and time % 3 == 0:
		energy -= .05
	elif time >= 19.5 * TICKS and time < 20 * TICKS and time % 3 == 0:
		mode = Light2D.MODE_SUB
		energy += .05

func send_sun_damage():
	if time % 10 == 0:
		if time >= 7 * TICKS and time < 19 * TICKS:
			emit_signal("sun_damage")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
