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

int obstacleCollision(struct rectangle player, struct obstacle o) {
  return 
    player.row + player.height >= o.row &&
    player.row <= o.row + o.height &&
    player.col + player.length >= o.col &&
    player.col <= o.col + o.length;
}

int main(void) {
  /* TODO: */
  // Manipulate REG_DISPCNT here to set Mode 3. //
  REG_DISPCNT = MODE3 | BG2_ENABLE;
  // Save current and previous state of button input.
  u32 previousButtons = BUTTONS;
  u32 currentButtons = BUTTONS;

  // Load initial application state
  struct rectangle player;
  player.row = HEIGHT - 8;
  player.col = 4;
  player.height = 8;
  player.length = 8;
  player.lives = 3;

  // obstacles 
  struct obstacle a1;
  struct obstacle a2;
  struct obstacle a3;
  struct obstacle a4;
  struct obstacle a5;
  
  a1.row = 130;
  a1.col = 15;
  a1.length = 10;
  a1.height = 10;
  a1.speedX = 1;
  a1.speedY = 1;

  a2.row = 105;
  a2.col = 215;
  a2.length = 10;
  a2.height = 10;
  a2.speedX = -1;
  a2.speedY = 1;

  a3.row = 80;
  a3.col = 15;
  a3.length = 10;
  a3.height = 10;
  a3.speedX = 1;
  a3.speedY = 1;

  a4.row = 55;
  a4.col = 215;
  a4.length = 10;
  a4.height = 10;
  a4.speedX = -1;
  a4.speedY = 1;

  a5.row = 30;
  a5.col = 15;
  a5.length = 10;
  a5.height = 10;
  a5.speedX = 1;
  a5.speedY = 1;

  // spawn and winning tiles
  struct rectangle spawn;
  struct rectangle goal;

  spawn.row = 144;
  spawn.col = 0;
  spawn.length = 16;
  spawn.height = 16;
  spawn.lives = 0;

  goal.row = 0;
  goal.col = 224;
  goal.length = 16;
  goal.height = 16;
  goal.lives = 0;

  // walls
  struct obstacle wallOne;
  wallOne.row = 140;
  wallOne.col = 0;
  wallOne.length = 210;
  wallOne.height = 4;
  wallOne.speedX = 0;
  wallOne.speedY = 0;

  struct obstacle wallTwo;
  wallTwo.row = 16;
  wallTwo.col = 30;
  wallTwo.length = 210;
  wallTwo.height = 4;
  wallTwo.speedX = 0;
  wallTwo.speedY = 0;
  
  enum gba_state state = START;
  fillScreenDMA(WHITE);
  while (1) {
    currentButtons = BUTTONS; // Load the current state of the buttons

    /* TODO: */
    // Manipulate the state machine below as needed //
    // NOTE: Call waitForVBlank() before you draw
    waitForVBlank();
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
        drawRectDMA(a1.row, a1.col, a1.length, a1.height, GRAY);
        drawRectDMA(a2.row, a2.col, a2.length, a2.height, GRAY);
        drawRectDMA(a3.row, a3.col, a3.length, a3.height, GRAY);
        drawRectDMA(a4.row, a4.col, a4.length, a4.height, GRAY);
        drawRectDMA(a5.row, a3.col, a5.length, a5.height, GRAY);
        drawRectDMA(wallOne.row, wallOne.col, wallOne.length, wallOne.height, GRAY);
        drawRectDMA(wallTwo.row, wallTwo.col, wallTwo.length, wallTwo.height, GRAY);
        drawRectDMA(spawn.row, spawn.height, spawn.length, spawn.height, GRAY);
        drawRectDMA(goal.row, goal.height, goal.length, goal.height, GRAY);

        // logic stuff
        if (KEY_DOWN(BUTTON_UP, currentButtons) && player.row > 0) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
            // do nothing
            if (player.col == wallOne.col || player.col == wallOne.col + wallOne.length || player.row + player.height == wallOne.row) {
              player.row -= 1;
            }
          } else {
            player.row -= 1;
          }
        }
        if (KEY_DOWN(BUTTON_DOWN, currentButtons) && player.row < HEIGHT - player.height) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
            if (player.col == wallOne.col || player.col == wallOne.col + wallOne.length || player.row == wallOne.row + wallOne.height) {
              player.row += 1;
            }
          } else {
            player.row += 1;
          }
        }
        if (KEY_DOWN(BUTTON_LEFT, currentButtons) && player.col > 0) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
              if (player.col == wallOne.col || player.row == wallOne.row + wallOne.height || player.row + player.height == wallOne.row) {
                player.col -= 1;
              }
          } else {
            player.col -= 1;
          }
        }
        if (KEY_DOWN(BUTTON_RIGHT, currentButtons) && player.col < WIDTH - player.length) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
              if (player.col == wallOne.col + wallOne.length || player.row == wallOne.row + wallOne.height || player.row + player.height == wallOne.row) {
                player.col += 1;
              }
          } else {
            player.col += 1;
          }
        }

        if (a1.col == WIDTH - a1.length || a1.col == 0) {
          a1.speedX = -a1.speedX;
          a2.speedX = -a2.speedX;
          a3.speedX = -a3.speedX;
          a4.speedX = -a4.speedX;
          a5.speedX = -a5.speedX;
        }
        a1.col += a1.speedX;
        a2.col += a2.speedX;
        a3.col += a3.speedX;
        a4.col += a4.speedX;
        a5.col += a5.speedX;

        if (obstacleCollision(player, a1) || 
            obstacleCollision(player, a2) || 
            obstacleCollision(player, a3) || 
            obstacleCollision(player, a4) ||
            obstacleCollision(player, a5)) {
            player.row = 145;
            player.col = 15;
            if (player.lives - 1 == 0) {
              state = LOSE;
              fillScreenDMA(RED);
            } else {
              player.lives--;
            }
        }

        // check for win
        if (player.row <= 20 && player.col >= 210) {
          state = WIN;
          fillScreenDMA(GREEN);
        }

        // drawing stuff
        drawRectDMA(a1.row, a1.col, a1.length, a1.height, RED);
        drawRectDMA(a2.row, a2.col, a2.length, a2.height, RED);
        drawRectDMA(a3.row, a3.col, a3.length, a3.height, RED);
        drawRectDMA(a4.row, a4.col, a4.length, a4.height, RED);
        drawRectDMA(a5.row, a3.col, a5.length, a5.height, RED);
        drawRectDMA(wallOne.row, wallOne.col, wallOne.length, wallOne.height, WHITE);
        drawRectDMA(wallTwo.row, wallTwo.col, wallTwo.length, wallTwo.height, WHITE);
        drawRectDMA(spawn.row, spawn.col, spawn.length, spawn.height, MAGENTA);
        drawRectDMA(goal.row, goal.col, goal.length, goal.height, GREEN);
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

