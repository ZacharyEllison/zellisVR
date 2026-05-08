# zellisVR

Godot 4.6 VR prototype with OpenXR passthrough and hand tracking.

## Overview

A VR experience built on Meta Quest hardware featuring:

- **Passthrough** — Mixed reality via Meta Quest passthrough (see-through camera feed)
- **Hand tracking** — Full two-hand skeletal tracking with humanoid mesh overlay
- **Gesture recognition** — Fist detection mapped to grip actions for object interaction
- **Pickable objects** — Physics-based blocks that can be grabbed, thrown, and manipulated
- **Menu system** — Placeholder UI (in development)

## Quick Start

1. Open the project in **Godot 4.6**
2. Press **F5** to run (or use the VR play button)
3. Put on your Meta Quest headset
4. Calibrate hand tracking when prompted
5. Make a **fist** with each hand to "grab" objects
6. Open your hand to release

## Scene Structure

```
main.tscn (root scene)
├── Player (XROrigin3D from player.tscn)
│   ├── XRCamera3D (eye level, 1.508m height)
│   ├── left hand (XRNode3D → LeftHandHumanoid mesh)
│   │   ├── HandPoseController (fist → grip mapping)
│   │   └── XRController3D → FunctionPickup (grab distance: 0.01m)
│   └── right hand (XRNode3D → RightHandHumanoid mesh)
│       ├── HandPoseController (fist → grip mapping)
│       └── XRController3D → FunctionPickup (grab distance: 0.01m)
├── blocks (Node3D)
│   ├── block (pickable, at origin + offset)
│   ├── block2
│   ├── block3
│   └── block4
├── omni (OmniLight3D)
├── WorldEnvironment (custom transparent sky)
└── StartXR (enables passthrough)
```

### player.tscn — XR Setup

- **XROrigin3D**: World-space anchor for the player
- **XRCamera3D**: Player's eyes (1.508m tall, 1.5 h-offset for IPD)
- **Hand tracking**: Left/right XRNode3D → humanoid skeleton meshes
- **HandPoseController**: Detects poses (currently: fist) and maps to XR controller actions
- **Virtual controllers**: XRController3D nodes driven by hand pose data, not physical controllers
- **FunctionPickup**: Grab/drop mechanics on both hands (0.01m grab radius = gesture-based)
- **OpenXRRenderModelManager**: Loads rendered hand models

### block.tscn — Pickable Object

- Extends `pickable.tscn` from godot-xr-tools
- 10cm × 10cm × 10cm cube with collision shape
- Supports ranged grab and second-hand grab
- Physics-enabled (can be thrown, stacked, etc.)

### menu.tscn — UI Placeholder

- Blue background with 3 placeholder buttons
- Not yet connected to any logic
- **TODO**: Connect buttons to scene switching, settings, etc.

## Addons

| Addon                  | Purpose                                                                                                |
| ---------------------- | ------------------------------------------------------------------------------------------------------ |
| **godot-xr-tools**     | Core XR framework — pickup, controllers, XR origin, render models                                      |
| **hand_pose_detector** | Hand pose recognition — detects gestures (fist, etc.) and maps them to XR controller inputs            |
| **godot_mcp**          | MCP server for Godot editor integration — enables AI agent to control Godot via Model Context Protocol |
| **debug_api**          | Debug utilities for the editor                                                                         |
| **godotopenxrvendors** | Meta Quest + AndroidXR OpenXR runtime binaries                                                         |

### hand_pose_detector Details

- **Poses**: `fist.tres` — detected fist pose
- **Actions**: `grip` — maps fist closure to controller grip input
- **Controllers**: Left/right virtual controllers driven by hand pose, not physical controller input
- **Tracker**: Uses `/user/hand_tracker/left` and `/user/hand_tracker/right` OpenXR paths

## OpenXR Configuration

Enabled in `project.godot` under `[xr]`:

- Hand tracking: ✅
- Hand interaction profile: ✅
- Render models: ✅
- HTC passthrough: ✅
- Meta passthrough: ✅
- Meta hand tracking aim: ✅
- Meta hand tracking mesh: ✅
- Meta hand tracking capsules: ✅
- Simultaneous hands + controllers: ✅

## Project Settings

- **Engine**: Godot 4.6.stable
- **Renderer**: GL Compatibility (OpenGL)
- **Features**: "4.6", "GL Compatibility"
- **Main scene**: `res://main.tscn`
- **Physics ticks**: 60/s
- **VR form factor**: Headset (0)

## Development Notes

### Hand Tracking Pipeline

```
OpenXR hand tracker → XRNode3D → Skeleton3D → HandPoseController → Virtual Controller → FunctionPickup
```

### Adding New Poses

1. Create a new `.tres` pose resource in `addons/hand_pose_detector/poses/`
2. Add it to the HandPoseSet in `player.tscn`
3. Define the action mapping in the HandPoseActionMap

### Adding New Pickable Objects

1. Instantiate `addons/godot-xr-tools/objects/pickable.tscn`
2. Add your mesh and collision shape as children
3. Place in the `blocks` node (or create a new container)

### Menu Development

The menu scene (`menu.tscn`) is a starting point. To connect it:

1. Create a script for the menu CanvasLayer
2. Connect button `pressed` signals to scene switching logic
3. Use `get_tree().change_scene_to_file("res://main.tscn")` to switch scenes

## MCP Integration

The `godot_mcp` addon exposes 40 tools for AI agent control of Godot:

- **Scene manipulation**: create/open/save scenes, get scene tree
- **Script editing**: read/create/modify GDScript files
- **Editor control**: run/stop project, get editor state, set editor settings
- **Project info**: settings, resources, directory structure

Connect from the Pi coding agent via HTTP on `http://localhost:9080/mcp`.

## Known Issues / TODO

- [ ] Menu system is non-functional (placeholder buttons)
- [ ] No scene switching between menu and VR
- [ ] Block materials are default white (no custom textures)
- [ ] No audio
- [ ] No save/load state
- [ ] Hand pose calibration could be more responsive
- [ ] Consider adding controller vibration feedback via XRToolsRumbleManager
