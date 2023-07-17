#include "main.h"

#include <stdio.h>
#include <stdlib.h>

#include "gba.h"
/* TODO: */
// Include any header files for title screen or exit
// screen images generated by nin10kit. Example for the provided garbage
// image:
// #include "images/garbage.h"
#include "images/start_screen.h"
#include "images/win_screen.h"
#include "images/lose_screen.h"
#include "images/obstacle.h"
#include "images/background.h"
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

void intializeAllObjects(struct rectangle *player, struct obstacle *one, struct obstacle *two, struct obstacle *three, struct obstacle *four, struct obstacle *five, struct rectangle *goal, struct rectangle *spawn, struct obstacle *wallOne, struct obstacle *wallTwo) {
  player->row = HEIGHT - 8;
  player->col = 4;
  player->height = 8;
  player->length = 8;
  player->lives = 3;

  one->row = 130;
  one->col = 15;
  one->length = 10;
  one->height = 10;
  one->speedX = 1;
  one->speedY = 1;

  two->row = 105;
  two->col = 215;
  two->length = 10;
  two->height = 10;
  two->speedX = -1;
  two->speedY = 1;

  three->row = 80;
  three->col = 15;
  three->length = 10;
  three->height = 10;
  three->speedX = 1;
  three->speedY = 1;

  four->row = 55;
  four->col = 215;
  four->length = 10;
  four->height = 10;
  four->speedX = -1;
  four->speedY = 1;

  five->row = 30;
  five->col = 15;
  five->length = 10;
  five->height = 10;
  five->speedX = 1;
  five->speedY = 1;

  spawn->row = 144;
  spawn->col = 0;
  spawn->length = 16;
  spawn->height = 16;
  spawn->lives = 0;

  goal->row = 0;
  goal->col = 224;
  goal->length = 16;
  goal->height = 16;
  goal->lives = 0;

  wallOne->row = 140;
  wallOne->col = 0;
  wallOne->length = 210;
  wallOne->height = 4;
  wallOne->speedX = 0;
  wallOne->speedY = 0;

  wallTwo->row = 16;
  wallTwo->col = 30;
  wallTwo->length = 210;
  wallTwo->height = 4;
  wallTwo->speedX = 0;
  wallTwo->speedY = 0;
  
  return;
}

void undrawObjects(struct rectangle *player, struct obstacle *a1, struct obstacle *a2, struct obstacle *a3, struct obstacle *a4, struct obstacle *a5, struct rectangle *goal, struct rectangle *spawn, struct obstacle *wallOne, struct obstacle *wallTwo) {
  UNUSED(*a1);
  UNUSED(*a2);
  UNUSED(*a3);
  UNUSED(*a4);
  UNUSED(*a5);
  drawRectDMA(player->row, player->col, player->length, player->height, BLACK);
  undrawImageDMA(a1->row, a1->col, a1->length, a1->height, background);
  undrawImageDMA(a2->row, a2->col, a2->length, a2->height, background);
  undrawImageDMA(a3->row, a3->col, a3->length, a3->height, background);
  undrawImageDMA(a4->row, a4->col, a4->length, a4->height, background);
  undrawImageDMA(a5->row, a3->col, a5->length, a5->height, background);
  drawRectDMA(wallOne->row, wallOne->col, wallOne->length, wallOne->height, BLACK);
  drawRectDMA(wallTwo->row, wallTwo->col, wallTwo->length, wallTwo->height, BLACK);
  drawRectDMA(spawn->row, spawn->col, spawn->length, spawn->height, BLACK);
  drawRectDMA(goal->row, goal->col, goal->length, goal->height, BLACK);  
}

void drawObjects(struct rectangle *player, struct obstacle *a1, struct obstacle *a2, struct obstacle *a3, struct obstacle *a4, struct obstacle *a5, struct rectangle *goal, struct rectangle *spawn, struct obstacle *wallOne, struct obstacle *wallTwo) {
  drawImageDMA(a1->row, a1->col, 10, 10, obstacle);
  drawImageDMA(a2->row, a2->col, a2->length, a2->height, obstacle);
  drawImageDMA(a3->row, a3->col, a3->length, a3->height, obstacle);
  drawImageDMA(a4->row, a4->col, a4->length, a4->height, obstacle);
  drawImageDMA(a5->row, a5->col, a5->length, a5->height, obstacle);
  drawRectDMA(wallOne->row, wallOne->col, wallOne->length, wallOne->height, WHITE);
  drawRectDMA(wallTwo->row, wallTwo->col, wallTwo->length, wallTwo->height, WHITE);
  drawRectDMA(spawn->row, spawn->col, spawn->length, spawn->height, MAGENTA);
  drawRectDMA(goal->row, goal->col, goal->length, goal->height, GREEN);
  drawRectDMA(player->row, player->col, player->length, player->height, BLUE);
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
  // obstacles 
  struct obstacle a1;
  struct obstacle a2;
  struct obstacle a3;
  struct obstacle a4;
  struct obstacle a5;
  // spawn and winning tiles
  struct rectangle spawn;
  struct rectangle goal;
  // walls
  struct obstacle wallOne;
  struct obstacle wallTwo;

  intializeAllObjects(&player, &a1, &a2, &a3, &a4, &a5, &goal, &spawn, &wallOne, &wallTwo);
  
  enum gba_state state = START;
  drawFullScreenImageDMA(start_screen);
  while (1) {
    currentButtons = BUTTONS; // Load the current state of the buttons
    waitForVBlank();
    switch (state) {

      case START:
        undrawObjects(&player, &a1, &a2, &a3, &a4, &a5, &goal, &spawn, &wallOne, &wallTwo);
        drawFullScreenImageDMA(start_screen);
        player.row = HEIGHT - 8;
        player.col = 4;
        player.lives = 3;
        if (KEY_JUST_PRESSED(BUTTON_START, currentButtons, previousButtons)) {
          state = PLAY;
          fillScreenDMA(BLACK);
        }
        break;

      case PLAY:
        // undraw objects
        undrawObjects(&player, &a1, &a2, &a3, &a4, &a5, &goal, &spawn, &wallOne, &wallTwo);

        // logic stuff
        // 1st if block checks if player is touching a wall
        if (KEY_DOWN(BUTTON_UP, currentButtons) && player.row > 0) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
            // 2nd if block allows player to moves in certain directions when touching a wall
            if (player.col == wallOne.col + wallOne.length || player.row + player.height == wallOne.row ||
            player.col + player.length == wallTwo.col || player.row + player.height == wallTwo.row) {
              player.row -= 1;
            }
          } else {
            player.row -= 1;
          }
        }
        if (KEY_DOWN(BUTTON_DOWN, currentButtons) && player.row < HEIGHT - player.height) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
            if (player.col == wallOne.col + wallOne.length || player.row == wallOne.row + wallOne.height ||
            player.col + player.length == wallTwo.col || player.row == wallTwo.row + wallTwo.height) {
              player.row += 1;
            }
          } else {
            player.row += 1;
          }
        }
        if (KEY_DOWN(BUTTON_LEFT, currentButtons) && player.col > 0) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
              if (player.row == wallOne.row + wallOne.height || player.row + player.height == wallOne.row ||
              player.col + player.length == wallTwo.col || player.row == wallTwo.row + wallTwo.height || player.row + player.height == wallTwo.row) {
                player.col -= 1;
              }
          } else {
            player.col -= 1;
          }
        }
        if (KEY_DOWN(BUTTON_RIGHT, currentButtons) && player.col < WIDTH - player.length) {
          if (obstacleCollision(player, wallOne) || obstacleCollision(player, wallTwo)) {
              if (player.col == wallOne.col + wallOne.length || player.row == wallOne.row + wallOne.height || player.row + player.height == wallOne.row ||
              player.row + player.height == wallTwo.row || player.row == wallTwo.row + wallTwo.height) {
                player.col += 1;
              }
          } else {
            player.col += 1;
          }
        }

        // obstacles change directions when they touch the map's boundary
        if (a1.col == WIDTH - a1.length || a1.col == 0) {
          a1.speedX = -a1.speedX;
          a2.speedX = -a2.speedX;
          a3.speedX = -a3.speedX;
          a4.speedX = -a4.speedX;
          a5.speedX = -a5.speedX;
        }
        
        // updates obstacle position
        a1.col += a1.speedX;
        a2.col += a2.speedX;
        a3.col += a3.speedX;
        a4.col += a4.speedX;
        a5.col += a5.speedX;

        // player loses life if they touch obstacle. if they lose all their lives, game transitions to lose state
        if (obstacleCollision(player, a1) || 
            obstacleCollision(player, a2) || 
            obstacleCollision(player, a3) || 
            obstacleCollision(player, a4) ||
            obstacleCollision(player, a5)) {
            player.row = 145;
            player.col = 15;
            if (player.lives - 1 == 0) {
              state = LOSE;
            } else {
              player.lives--;
            }
        }

        // checks if player positon matches goal tile 
        if (player.row <= goal.row + goal.height && player.col >= goal.col) {
          state = WIN;
        }

        drawObjects(&player, &a1, &a2, &a3, &a4, &a5, &goal, &spawn, &wallOne, &wallTwo);
        drawChar(150, 4, player.lives + 48, BLACK);

        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          state = START;
        }
        break;
      case WIN:
        
        drawChar(20, 20, player.lives, BLUE);
        drawFullScreenImageDMA(win_screen);
        drawRectDMA(player.row, player.col, player.length, player.height, BLUE);
        // state = ?
        if (KEY_JUST_PRESSED(BUTTON_START, currentButtons, previousButtons)) {
          state = START;
          undrawImageDMA(0, 0, WIDTH, HEIGHT, start_screen);
        }
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          state = START;
        }
        break;
      case LOSE:
        drawRectDMA(player.row, player.col, player.length, player.height, GRAY);
        drawRectDMA(a1.row, a1.col, a1.length, a1.height, GRAY);
        drawRectDMA(a2.row, a2.col, a2.length, a2.height, GRAY);
        drawRectDMA(a3.row, a3.col, a3.length, a3.height, GRAY);
        drawRectDMA(a4.row, a4.col, a4.length, a4.height, GRAY);
        drawRectDMA(a5.row, a3.col, a5.length, a5.height, GRAY);
        drawRectDMA(wallOne.row, wallOne.col, wallOne.length, wallOne.height, GRAY);
        drawRectDMA(wallTwo.row, wallTwo.col, wallTwo.length, wallTwo.height, GRAY);
        drawRectDMA(spawn.row, spawn.col, spawn.length, spawn.height, GRAY);
        drawRectDMA(goal.row, goal.col, goal.length, goal.height, GRAY);
        drawFullScreenImageDMA(lose_screen);
        // state = ?
        if (KEY_JUST_PRESSED(BUTTON_START, currentButtons, previousButtons)) {
          state = START;
          undrawImageDMA(0, 0, WIDTH, HEIGHT, start_screen);
        }
        if (KEY_JUST_PRESSED(BUTTON_SELECT, currentButtons, previousButtons)) {
          state = START;
        }
        break;
    }

    previousButtons = currentButtons; // Store the current state of the buttons
  }

  UNUSED(previousButtons); // You can remove this once previousButtons is used

  return 0;
}

