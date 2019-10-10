extends CanvasLayer

var format_string = "%s:%s  %s"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass	

func update_time_label(time, ticks):
	# display correct time in label
	var string_elements = ["", "", "AM"]
	string_elements[0] = floor(time / ticks)
	string_elements[1] = str(time % ticks).pad_zeros(2)
	if time >= 12 * ticks:
		string_elements[2] = "PM"
		string_elements[0] -= 12
	if string_elements[0] == 0:
		string_elements[0] = 12
	$TimeLabel.text = format_string % string_elements

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

