### TODO
- DIMENSION state

### FIX

### IMPROVEMENTS
- refactor: 
    - reduce the number of is_none and is_path in interface
    - remove boolean base states in interface
    - at interface/idungeon/idungeon.gd
- interface
    - add move/attack/ability/cancel and guard/wait/cancel menus (retire old guard/wait menu)
        - add ability to toggle dungeon/pool view during menu
        - disable enturn during dmenu and action selection
    - switch selected monster even if another monster is already selected
    - merge dice_info and summon_info to share common interfaces?
- art:
    - make player specific summon sprites
    - add type colors for dice

### TEST
- attack mechanics
