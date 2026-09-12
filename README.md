# The Best Wario Game Ever Made

A fast four-round WarioWare-style challenge where every second counts on the climb to the summit.

![WarioWare Mountain Challenge key art](thebest-wariogameevermade/assets/game2-key-art.svg)

## Try it

**[Play the browser demo on itch.io](https://steff11.itch.io/the-best-wario-game-ever-made)**

## Quick start

1. Open the demo link above.
2. Choose **Start Game**.
3. Complete all four timed minigames before losing all five lives.

## Features

- A timed garlic-clicking round with four targets.
- A moving star-catching round that rewards quick mouse clicks.
- A direction-signal round that accepts arrow keys or matching on-screen buttons.
- A five-life system, countdown transitions, replay flow, original winner scene, and original death scene.

## How it works

Each round is a separate Godot scene with a small script that owns its timer, input handling, progress, and success/failure result. The transition scene keeps the four-round sequence readable: it updates the level counter, shows the remaining lives, and launches the next scene. A failed round costs one life and retries that round after the transition; completing round four opens the winner scene.

The new Signal Summit round uses a fixed directional pattern so the challenge is predictable and testable. The same action functions are called by both keyboard input and the four mouse buttons, keeping the two control paths consistent.

## Controls

- Platformer: **A/D** or **Left/Right** to move; **W**, **Space**, **Enter**, or **JUMP** to jump.
- Other rounds: click the targets directly.
- Signal Summit: press **Up**, **Right**, **Down**, or **Left**, or click the matching button.
- Open **Settings** from the title screen for the in-game reminder.

## Assets and credits

- The selected mountain background remains part of the game, while the active winner and death screens use original vector illustrations in `assets/winner-screen.svg` and `assets/death-screen.svg`.
- The key art, garlic targets, and summit runner in `assets/game2-key-art.svg`, `assets/garlic-target.svg`, and `assets/player.svg` are original vector illustrations created for this project.
- The Signal Summit interface uses original layout, color, and arrow artwork built in the Godot scene.

## Links

- [Play the browser demo](https://steff11.itch.io/the-best-wario-game-ever-made)
- [GitHub repository](https://github.com/costachestefy90-source/WarioGame)
