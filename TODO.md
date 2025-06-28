## FEATURES
- Dimension
    - Add dice dimension controls
- Add SKIP button in rollzone
- Add ENDTURN button to dungeon gui

## IMPROVEMENTS
- code refactoring
    - finished dicepool
    - will global signals work when playing with two players?
        - change all globals singals for signals controlled by player_gui
- change dice nad dungobj colors

## FIXES
- rolls sometimes not working, locking the game
    - probably in case the game detect dice stopping but they keep moving
    - set code to monitor while tesitng
