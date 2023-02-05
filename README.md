# DDMre (Dungeon Dice Monsters re-implementation)
<p align="center">
<img src="https://github.com/francocurotto/DDMre/blob/master/images/example1.jpg" width="300" />&nbsp; &nbsp; &nbsp; &nbsp;
<img src="https://github.com/francocurotto/DDMre/blob/master/images/example2.jpg" width="300" />
</p>

# What is this?
**DDMre** is a re-implementation of the GBA game [Yu-Gi-Oh! Dungeon Dice Monsters](https://en.wikipedia.org/wiki/Yu-Gi-Oh!_Dungeon_Dice_Monsters) in the [Godot game engine](https://godotengine.org/) for mobile devices. The idea is to re-implement the core game mechanics from the game, taking only a few liberties, while adding some modern features like a decent AI, and possibly online multiplayer. *It is in a very early stage* of development and even some core game mechanics are not implemented yet (ABILITIES).

# What is left to do? (A LOT)
- Implement abilities of monsters and items
- Improve UI and graphics
- Add opponents, and decent AI
- _Maybe_ online multiplayer

# Differences with the original (GBA) game and this
- In the original, block tiles not only block their positions but also their neighbour positions (up, down, left right). In this implementation, a block tile will only block its actual position.
- In the original, movement cost is computed by dividing monster speed as float then multiplying dungeon move cost as float and then rounding to the highest int. For simplicity, in this implementation the cost is converted to int both after dividing the speed and multiplying the move cost. This difference is only relevant when combining a moster with higher speed and the gluminizer ability. For example for a monster with speed 3 and the gluminizer ability (move cost 2) the total movement cost is:
    - original costs per tile: 1,2,2,3,4,4,5,6,6...
    - new costs per tile: 2,2,2,4,4,4,6,6,6...

# Why?
I first got captivated by Dungeon Dice Monsters when I saw it in the anime. I thought that the mechanics and complexity of the game made it even more interesting than the original card game. When I learned about the GBA game, I knew I had to try it. Unfortunately, the game is really held back by the terrible AI programming of the opponents: stupid dimension positions, nonsensical monster movements, failed attempts to defend the monster lord, etc. I would argue the AI is so bad that is even harder to lose intentionally to your opponent than to beat them[^1].

So this always made me wonder what would it be if this game had been implemented today, with better playability and modern features. But Konami hasn't touch this game since then, so I decided to take the matter into my own hand. I don't know how far I'll be able to get, but at least I can try.

[^1]: I even remember I would self-impose rules to handicap myself and make the game more interesting, like only allowing me to summon monster levels 3 and 4. Unfortunately this only made the game longer not harder. 
