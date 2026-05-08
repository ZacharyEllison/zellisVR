## Desktop Support Auto-Setup
## Attach this to XROrigin3D in player.tscn.
## Automatically adds desktop (non-VR) controls when not in XR mode.
extends XROrigin3D

func _ready():
	# Skip if already set up
	if get_node_or_null("MovementDesktopDirect"):
		return
	
	var camera = get_node("XRCamera3D")
	
	# MovementDesktopDirect - WASD movement
	var movement = load("res://addons/godot-xr-tools/desktop-support/movement_desktop_direct.tscn").instantiate()
	movement.name = "MovementDesktopDirect"
	movement.max_speed = 5.0
	movement.strafe = true
	add_child(movement)
	
	# MouseCapture - mouse look
	var mouse_capture = load("res://addons/godot-xr-tools/desktop-support/mouse_capture.tscn").instantiate()
	mouse_capture.name = "MouseCapture"
	add_child(mouse_capture)
	
	# ControllerHider - hide XR controllers in desktop mode
	var controller_hider = load("res://addons/godot-xr-tools/desktop-support/controller_hider.tscn").instantiate()
	controller_hider.name = "ControllerHider"
	add_child(controller_hider)
	
	# FunctionDesktopPointer - raycast pointer under camera
	var pointer = load("res://addons/godot-xr-tools/desktop-support/function_desktop_pointer.tscn").instantiate()
	pointer.name = "DesktopPointer"
	pointer.active_button_action = "ui_accept"
	pointer.collision_mask = 5242880
	if camera:
		camera.add_child(pointer)
	
	print("Desktop support auto-configured")
