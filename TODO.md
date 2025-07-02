## FEATURES
- Dimension
    - Add dice dimension controls
- Add SKIP button in rollzone
- Add ENDTURN button to dungeon gui

## IMPROVEMENTS
- code refactoring
    - finished dice_gui
    - refactor touch controls into a control node
- change dice and dungobj colors
- make rollzone walls angled

## FIXES
- rolls sometimes not working, locking the game
    - probably in case the game detect dice stopping but they keep moving
    - set code to monitor while tesitng
