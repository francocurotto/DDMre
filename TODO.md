## FEATURES
- Dimension
    - Add dice dimension controls
- Add SKIP button in rollzone
- Add ENDTURN button to dungeon gui

## IMPROVEMENTS
- code refactoring
    - finished dice_gui
- change dice and dungobj colors
- make rollzone walls angled
- make dice_button more distiguishible from pressed and not pressed

## FIXES
- fix dimdice rotations to not accumulate so the dice gets cocked
- rolls sometimes not working, locking the game
    - probably in case the game detect dice stopping but they keep moving
    - set code to monitor while tesitng
