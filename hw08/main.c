#include "main.h"

#include <stdio.h>
#include <stdlib.h>

#include "gba.h"
/* TODO: */
// Include any header files for title screen or exit
// screen images generated by nin10kit. Example for the provided garbage
// image:
// #include "images/garbage.h"

/* TODO: */
// Add any additional states you need for your app. You are not requried to use
// these specific provided states.
enum gba_state {
  START,
  PLAY,
  WIN,
  LOSE,
};

int main(void) {
  /* TODO: */
  // Manipulate REG_DISPCNT here to set Mode 3. //
  REG_DISPCNT = MODE3 | BG2_ENABLE;
  // Save current and previous state of button input.
  u32 previousButtons = BUTTONS;
  u32 currentButtons = BUTTONS;

  // Load initial application state
  struct rectangle player;
  player.row = 20;
  player.col = 20;
  player.height = 8;
  player.length = 8;

  enum gba_state state = START;
  fillScreenDMA(WHITE);
  while (1) {
    currentButtons = BUTTONS; // Load the current state of the buttons

    /* TODO: */
    // Manipulate the state machine below as needed //
    // NOTE: Call waitForVBlank() before you draw

    switch (state) {
      case START:
        if (KEY_JUST_PRESSED(BUTTON_START, currentButtons, previousButtons)) {
          state = PLAY;
          // draw whatever is needed to start the game (the walls, players, obstacles)
          fillScreenDMA(GRAY);
        }
        // state = ?
        break;
      case PLAY:
        // undrawing player
        drawRectDMA(player.row, player.col, player.length, player.height, GRAY);

        // logic stuff
        if (KEY_DOWN(BUTTON_UP, currentButtons)) {
          player.row -= 1;
        }
        if (KEY_DOWN(BUTTON_DOWN, currentButtons)) {
          player.row += 1;
        }
        if (KEY_DOWN(BUTTON_LEFT, currentButtons)) {
          player.col -= 1;
        }
        if (KEY_DOWN(BUTTON_RIGHT, currentButtons)) {
          player.col += 1;
        }



        // drawing stuff
        drawRectDMA(player.row, player.col, player.length, player.height, BLUE);


        // change state
        break;
      case WIN:

        // state = ?
        break;
      case LOSE:

        // state = ?
        break;
    }

    previousButtons = currentButtons; // Store the current state of the buttons
  }

  UNUSED(previousButtons); // You can remove this once previousButtons is used

  return 0;
}
