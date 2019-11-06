extends KinematicBody2D

# whenever an item is added to backpack
signal item_added

var tile_size = 64
var move_speed = 128

var direction = Vector2()
var target_position = Vector2()
var last_position = Vector2()

var max_health = 10
var current_health = 10

# whether or not the player can interact, and the object to interact with
var can_interact = false
var interactable = null

# the players items
var backpack = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	last_position = position
	target_position = position
	$HealthBar/TextureProgress.max_value = max_health
	$HealthBar/TextureProgress.value = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_input():
	direction = Vector2()

	if Input.is_action_pressed('ui_a'):
		direction.x -= 1
	if Input.is_action_pressed('ui_d'):
		direction.x += 1
	if Input.is_action_pressed('ui_w'):
		direction.y -= 1
	if Input.is_action_pressed('ui_s'):
		direction.y += 1
	direction = direction.normalized() * move_speed
	
	# interaction
	if can_interact:
		if Input.is_action_just_pressed('ui_accept'):
			var action_dict = interactable.interact()
			if action_dict.has("add_to_bag"):
				var item = action_dict["add_to_bag"]
				backpack[item] = 1 if not backpack.has(item) else backpack[item] + 1
				emit_signal("item_added", item, backpack[item], 1)
	
	#if player is moving, signal should emit
	#if direction != Vector2():
	#	emit_signal("moving")


func _physics_process(delta):
	# position += direction * move_speed * delta
	get_input()
	move_and_slide(direction)
	
	# display corrent sprites
	if direction.x != 0:
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.flip_h = direction.x > 0
		$AnimatedSprite.playing = true
	else:
		$AnimatedSprite.playing = false
	
	# if no collisions, player cannot interact
	if get_slide_count() == 0:
		can_interact = false
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		can_interact = true
		interactable = collision.collider

func lose_health(damage):
	current_health -= damage
	if current_health < 0:
		current_health = 0
	$HealthBar/TextureProgress.value = current_health
	
	#if position.distance_to(last_position) >= tile_size:
	#	position = target_position
	#if position == target_position:
	#	get_input()
	#	last_position = position
	#	target_position += direction * tile_size
