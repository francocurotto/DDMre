### TODO
- DIMENSION state

### FIX

### IMPROVEMENTS
- refactor: 
    - reduce the number of is_none and is_path in interface
    - remove boolean base states in interface
    - at interface/idungeon/idungeon.gd
- art:
    - make player specific summon sprites
    - add type colors for dice
- interface
    - add move/attack/ability/cancel and guard/wait/cancel menus (retire old guard/wait menu)
        - add ability to toggle dungeon/pool view during menu
    - do not use move buttons for attack indicator
    - switch selected monster even if another monster is already selected
    - merge dice_info and summon_info to share common interfaces?

### TEST
- attack mechanics
