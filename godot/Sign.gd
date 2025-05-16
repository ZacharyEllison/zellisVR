extends MeshInstance3D

func _ready():
    # Set the sign's position 6.1 meters in front of the camera
    global_transform.origin = Vector3(0, 1.5, -6.1)
    
    # Create a gentle earth tone material
    var material = StandardMaterial3D.new()
    material.albedo_color = Color("#A67B5B") # Example earth tone
    material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
    material.albedo_texture = null
    material.metallic = 0.0
    material.roughness = 1.0
    material.alpha = 0.9 # Slight transparency for readability
    
    # Assign the material to the mesh
    mesh.surface_set_material(0, material)
