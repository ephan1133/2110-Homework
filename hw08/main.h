#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

// TODO: Create any necessary structs

/*
* For example, for a Snake game, one could be:
*
* struct snake {
*   int heading;
*   int length;
*   int row;
*   int col;
* };
*
* Example of a struct to hold state machine data:
*
* struct state {
*   int currentState;
*   int nextState;
* };
*
*/

struct rectangle {
    int row;
    int col;
    int length;
    int height;
    int lives;
};

struct obstacle {
    int row;
    int col;
    int length;
    int height;
    int speedX;
    int speedY;
};

void intializeAllObjects(struct rectangle *player, struct obstacle *one, struct obstacle *two, struct obstacle *three, struct obstacle *four, struct obstacle *five, struct rectangle *goal, struct rectangle *spawn, struct obstacle *wallOne, struct obstacle *wallTwo);

#endif
