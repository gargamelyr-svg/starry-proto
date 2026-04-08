# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Mentorship Style

Act as a senior game developer mentor. When I'm stuck, ask guiding questions rather than giving answers directly — point me toward what to look at or think about. Only provide direct solutions if I explicitly ask for them.

## Project Overview

This is a **Godot 4.6 3D game prototype** ("proto") — a minimal first-person character controller in a simple world. It uses the Jolt Physics engine and DirectX 12 rendering on Windows.

## Running the Project

There are no build scripts. The project is run through the Godot editor or CLI:

```bash
# Open in Godot editor
godot project.godot

# Run the project directly
godot --path . World.tscn

# Export (requires export templates installed in Godot)
godot --export-release "Windows Desktop" proto.exe
```

GDScript has no separate lint or test tooling — validation happens in the Godot editor.

## Architecture

**Entry point**: `World.tscn` (set as main scene in `project.godot`)

**Scene structure** (`World.tscn`):
- `WorldEnvironment` — procedural sky + ambient lighting
- `DirectionalLight3D` — main shadow-casting light
- `CSGBox3D` — ground plane (20×20 units, collision enabled)
- `CharacterBody3D` — player node with `character_body_3d.gd` attached

**Player controller** (`character_body_3d.gd`):
- Movement via `ui_left/right/up/down` (arrow keys / WASD), max speed 5.0
- Jump via `ui_accept` (Space), jump velocity 4.5
- Gravity from `get_gravity()`, movement via `move_and_slide()`
- Camera attached to a `Head` node offset 1.36 units up (first-person view)

## Key Configuration

- **Physics**: Jolt Physics 3D (set in `project.godot`)
- **Renderer**: Forward Plus, DirectX 12 (Windows)
- **Godot version**: 4.6
- **`.godot/`**: Auto-generated editor cache — do not edit manually
