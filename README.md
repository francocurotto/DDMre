# DDMre

## What is this?
**DDMre** is a reimplementation of the GBA game [Yu-Gi-Oh! Dungeon Dice Monsters](https://en.wikipedia.org/wiki/Yu-Gi-Oh!_Dungeon_Dice_Monsters) in the [Godot game engine](https://godotengine.org/). The idea is to reimplement the core game mechanics from the game, taking only a few liberties, while adding some modern features like a decent AI, and possibly online multiplayer. *It is in a very early stage* of  development and even some core game mechanics are not implemented yet (ABILITIES).

## What is left to do? (A LOT)
- Implement abilities of monsters and items
- Improve UI and graphics
- Add opponents, and decent AI
- _Maybe_ online multiplayer
- _Maybe_ mobile version

## Differences with the original (GBA) game and this
- In the original block tiles not only block their positions but also their neighbour positions (up, down, left right). In this implementation, a block tile will only block its actual position.

## Why?
I first got captivated by Dungeon Dice Monsters when I saw it in the anime. I thought that the mechanics and complexity of the game made it even more interesting than the original card game. When I learned about the GBA game, I knew I had to try it. Unfortunately, the game is really held back by the terrible AI programming of the opponents: stupid dimension positions, nonsensical monster movements, failed attempts to defend the monster lord, etc. I would argue the AI is so bad that is even harder to loose intentionally to your opponent than to beat them.

So this always made me wonder what would have been if this game had been implemented today, with better playability and modern features. But Konami hasn't touch this game since then, so I decided to take the matter in my own hand. I don't know how far I'll be able to get, but at least I can try.


