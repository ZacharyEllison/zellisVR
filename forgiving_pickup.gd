## ForgivingPickup - More reliable grabbing for hand tracking
## Extends FunctionPickup with larger grab distance and lower grip threshold
## Optimized for hand tracking where precision is limited

extends "res://addons/godot-xr-tools/functions/function_pickup.gd"

## Larger grab distance for hand tracking (15cm vs default 1cm)
@export var grab_distance_hand_tracking: float = 0.15

## Lower grip threshold for hand tracking (easier to trigger)
@export var grip_threshold_hand_tracking: float = 0.5

## Enable hand tracking mode automatically
@export var enable_hand_tracking_mode: bool = true

func _ready():
	super._ready()
	
	# Apply hand tracking settings if enabled
	if enable_hand_tracking_mode:
		grab_distance = grab_distance_hand_tracking
		_grip_threshold = grip_threshold_hand_tracking
		print("ForgivingPickup: grab_distance=" + str(grab_distance) + ", grip_threshold=" + str(_grip_threshold))
