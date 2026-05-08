## FallingBlock - Pickable blocks that fall when released and respawn on ground contact
## Extends pickable to get grab/drop signals, adds gravity and respawn behavior

extends "res://addons/godot-xr-tools/objects/pickable.gd"

## Store original transform for respawning
var original_transform: Transform3D

## Ground detection raycast
var ground_check: RayCast3D

## Respawn settings
@export var respawn_height: float = 2.0  ## Height above ground to respawn
@export var respawn_timer: float = 1.0  ## Seconds before respawning

## Track if we're waiting to respawn
var respawn_timer_elapsed: float = 0.0
var waiting_to_respawn: bool = false

func _ready():
	# Store original transform
	original_transform = global_transform
	
	# Create ground check raycast
	ground_check = RayCast3D.new()
	ground_check.target_position = Vector3(0, -5, 0)
	# Layer 1 = Static World (ground)
	ground_check.collision_mask = 1
	add_child(ground_check)
	
	# Connect to pickable signals
	picked_up.connect(_on_picked_up)
	dropped.connect(_on_dropped)
	
	print("FallingBlock ready at: " + str(original_transform.origin))

func _physics_process(delta):
	# Only check for ground contact when not held and not frozen
	if not waiting_to_respawn or freeze:
		return
	
	# Check if on ground
	if ground_check.is_colliding():
		var collider = ground_check.get_collider()
		# Only respawn if it's a static body (ground), not another pickable
		if collider is StaticBody3D:
			_respawn()
			return
	
	# Start respawn timer when first touching ground
	if not waiting_to_respawn:
		waiting_to_respawn = true
		respawn_timer_elapsed = 0.0
		print("Block on ground, starting respawn timer...")
	
	# Count down respawn timer
	respawn_timer_elapsed += delta
	if respawn_timer_elapsed >= respawn_timer:
		_respawn()

func _on_picked_up(_pickable):
	# Unfreeze when picked up so physics works
	freeze = false
	waiting_to_respawn = false
	print("Block picked up - physics enabled")

func _on_dropped(_pickable):
	# Ensure physics is active when dropped
	freeze = false
	waiting_to_respawn = false
	print("Block dropped - waiting for ground contact")

func _respawn():
	print("Respawning block...")
	
	# Reset to original position
	global_transform = original_transform
	
	# Clear all velocity
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	# Freeze again
	freeze = true
	
	# Reset state
	waiting_to_respawn = false
	respawn_timer_elapsed = 0.0
	
	print("Block respawned to: " + str(original_transform.origin))
