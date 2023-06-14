# DDMre (Dungeon Dice Monsters remake)
<p align="center">
<img src="https://github.com/francocurotto/DDMre/blob/master/images/example1.jpg" width="300" />&nbsp; &nbsp; &nbsp; &nbsp;
<img src="https://github.com/francocurotto/DDMre/blob/master/images/example2.jpg" width="300" />
</p>

# What is this?
**DDMre** is a remake of the GBA game [Yu-Gi-Oh! Dungeon Dice Monsters](https://en.wikipedia.org/wiki/Yu-Gi-Oh!_Dungeon_Dice_Monsters) in the [Godot game engine](https://godotengine.org/) for mobile devices. The idea is to recreate the core game mechanics from the game, taking only a few liberties, while adding some modern features like a decent AI, and possibly online multiplayer. 

*It is in a very early stage*  and is not playable yet.

# What is finished
- Core game mechanics during duel. Includes:
    - Roll of dice
    - Dimension of dice
    - Movement of monsters
    - Attack of monsters
    - Reply of attacks (guard and wait)
    - All 46 monsters and items abilities of the original (+2 extra)


# What is left to do? (A LOT)
- Improve UI and graphics
- Interface to create own dicepools
- Add opponents, and decent AI
- _Maybe_ online multiplayer

# Differences with the original (GBA) game
- In the original, block tiles not only block their positions but also their neighbour positions (up, down, left right). In this implementation, a block tile will only block its actual position.
- In original, you cannot activate a reply ability (as a reply to an attack) and "GUARD" the attack at the same time. This nerf reply abilities quite a bit, and makes some borderline useless (e.g. REDUCEDAMAGE, ADDDFOEDEFENSE). In this remake, monsters can GUARD and activate a reply ability simultaneously.
- In the original,  I consider Time Wizard ability DIMKILLWEAKEST to be broken, as it affects only opponent monsters, a dicepool full of Time Wizards could easily invalidate any other type of dicepools. In this remake, DIMKILLWEAKEST considers both player's monsters, so if the monster with the lowest attack is a player monster, it cannot be used to kill an opponent monster. 
- In the original, Knight of Twin Swords has the ability RAISEATTACK. In this remake this ability is replaced with a new ability called MULTIATTACK that a allows the monster to attack three times in one turn. This change is more in line with the ability description text and the anime.
- In the original Dark-eyes Illusionist has the ability PROTECTSELF. In this remake this ability is replaced with a new ability called NEGATEATKABI. When the ability is casted the player chooses a monster, the chosen monster cannot longer attack and its abilities are negated. This is more in line with the ability description text and casting cost.
- In the original, movement cost is computed by dividing monster speed as float then multiplying dungeon move cost as float and then rounding to the highest int. For simplicity, in this remake the cost is converted to int both after dividing the speed and multiplying the move cost. This difference is only relevant when combining a monster with speed 2 or higher and the GLUMINIZER ability. For example for a monster with speed 3 and the GLUMINIZER ability (move cost 2) the total movement cost is:
    - original costs per tile: 1,2,2,3,4,4,5,6,6...
    - new costs per tile: 2,2,2,4,4,4,6,6,6...

# Why?
I've always been a huge fan of Dungeon Dice Monsters game mechanics, but the few implementations that have been made are very lackluster. In particular, the GBA game (the only official video game version) is really held back by the terrible AI programming of the opponents: stupid dimension positions, nonsensical monster movements, failed attempts to defend the monster lord, etc. Konami has essentially abandoned this game, so I decided to make one of my own...
