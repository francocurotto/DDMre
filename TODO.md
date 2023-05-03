### TODO
- refactor action menu
    - standing abilities
        - add highligh functionality
    - dim abilities
    - ability buttons
- DIMKILLTUNNEL
- DIMKILLWEAKEST (change to cover all monsters)
---
- DIMCURE
---
- MONSTERREBORN

### FIXES
- add ability description in card info
    - add also in standing and state ability gui
    - implement ability_info
- bug found: in reply ability with select summon, if same ability is activated in the same turn, selection of summon is preserved, but it should be reset
- bug found: in reply ability with select summon, ability highlight is not reset after resolving attack
- standarize cmd syntax and context checks

### IMPROVEMENTS
- inconsistency: when ability select monster menu is activated, monsters are not highlighted, but if you go to select monster and cancel the monsters are kept highlighted. Basically when menu is open, there are two states, monsters highlighted and not highlighted
    - solution: separate ability_button and ability_highlight, activate highlight on gui opened and button on setect_button_pressed 
- change net select to next/previous net buttons
- change select_direction_buttons to be scrolls
- make summon actions and dim transformations menus popable in dungeon?

### ADDITIONS
- implement attack twice ability for Knight of Twin Swords
- implement better ability for Dark-eyes Iusionist
- add vortex initialization
- add neutral path tile for vortex at start

### ART
- test change tile icons
- make everything 16-bitish

### ABILITIES [42/46]
- ✅TUNNEL
- ✅FLY
- ✅ARCHER
- ✅NEUTRAL
- ❌DIMCURE
- ✅DIMCUREALL
- ❌DIMKILLWEAKEST
- ❌DIMKILLTUNNEL
- ✅DIMKILLTUNNELALL
- ✅DIMADDCREST
- ✅DIMTRADECREST
- ✅EXODIA
- ✅DIMBUFFDEADTYPE
- ✅STOPFLY
- ✅STOPTUNNEL
- ✅TURNSLOWTYPE
- ✅BUFFTYPE
- ✅PROTECTTYPE
- ✅FROZEN
- ✅MOVELIMIT
- ✅RAISESPEED
- ✅RAISEATTACK
- ✅REDUCEDAMAGE
- ✅REDUCEDAMAGEINF
- ✅SHIFTDAMAGE
- ✅PROTECTSELF
- ✅ADDFOEDEFENSE
- ✅KILLBLOCK
- ✅BUFFDAMAGE
- ✅BUFFSELF
- ✅TRADEHEALTH
- ✅STEALMONSTER
- ✅MINDCONTROL
- ✅ROLLLEVELKILL
- ✅RANGELEVELKILL
- ✅RANGEKILLALL
- ✅DISTANCEATTACK
- ✅ITEMCURE
- ✅ITEMDAMAGE
- ✅TIMEMACHINE
- ✅ITEMBUFF
- ✅ITEMCRESTKILL
- ❌MONSTERREBORN
- ✅BLACKHOLE
- ✅GLUMINIZER
- ✅WARPVORTEX
