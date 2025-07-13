## FEATURES
- Dimension
    - Add dice dimension controls
- Add SKIP button in rollzone
- Add ENDTURN button to dungeon gui

## IMPROVEMENTS
- code refactoring
    - refactor dice.gd

## FIXES
- I have the following bug:
    - while resolving roll the dice_stopped signal is emitted multiple times
        - problable because the dice is considered to move and stop again suring removing
        - if I remove the reset of the static_flag while moving I cannot reroll after cocked

## GRAPHICS
- change dice and dungobj colors
- make dice_button more distiguishible from pressed and not pressed
- make dice fade (dim selection) nicer
