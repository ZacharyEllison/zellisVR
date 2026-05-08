## HandVisibility - Makes hands transparent and shadowless for passthrough/AR mode
## Attach to XROrigin3D to auto-configure hand visibility

extends XROrigin3D

## How transparent the hands should be (0.0 = opaque, 1.0 = fully transparent)
@export var hand_alpha: float = 0.3

## Wireframe mode (true = wireframe, false = transparent)
@export var wireframe_mode: bool = false

func _ready():
	# Wait a frame for hands to load
	await get_tree().process_frame
	
	# Configure both hands
	_configure_hand("left")
	_configure_hand("right")
	
	print("Hand visibility configured: alpha=" + str(hand_alpha) + ", wireframe=" + str(wireframe_mode))

func _configure_hand(hand_name: String):
	var hand_node = get_node_or_null("XROrigin3D/" + hand_name)
	if not hand_node:
		print("Hand node not found: " + hand_name)
		return
	
	# Find the hand mesh (LeftHandHumanoid2 or RightHandHumanoid2)
	var hand_mesh = hand_node.get_node_or_null(hand_name.capitalize() + "2")
	if not hand_mesh:
		print("Hand mesh not found: " + hand_name)
		return
	
	# Recursively configure all mesh instances in the hand
	_configure_meshes(hand_mesh)
	
	print("Configured hand: " + hand_name)

func _configure_meshes(node: Node):
	if node is MeshInstance3D:
		_configure_mesh_instance(node as MeshInstance3D)
	
	# Recurse into children
	for child in node.get_children():
		_configure_meshes(child)

func _configure_mesh_instance(mesh: MeshInstance3D):
	# Disable shadows
	mesh.cast_shadow = 0  ## OFF
	
	# Configure material
	if mesh.material_override:
		# Use existing material
		var mat = mesh.material_override as StandardMaterial3D
		_configure_material(mat)
	elif mesh.get_surface_override_material(0):
		# Use surface override material
		var mat = mesh.get_surface_override_material(0) as StandardMaterial3D
		_configure_material(mat)
	else:
		# Create new transparent material
		var mat = StandardMaterial3D.new()
		mat.flags_unshaded = true
		mat.flags_transparent = true
		mat.albedo_color = Color(1, 1, 1, hand_alpha)
		if wireframe_mode:
			mat.flags_wireframe = true
		mesh.material_override = mat

func _configure_material(mat: StandardMaterial3D):
	# Make transparent
	mat.flags_transparent = true
	mat.flags_unshaded = true
	
	# Set alpha
	if wireframe_mode:
		mat.flags_wireframe = true
		mat.albedo_color = Color(0.5, 0.8, 1, 0.5)  # Blue wireframe
	else:
		mat.albedo_color = Color(1, 1, 1, hand_alpha)
	
	# Disable shadows
	mat.flags_shadow = false
