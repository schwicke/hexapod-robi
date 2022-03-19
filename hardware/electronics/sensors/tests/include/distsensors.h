#ifndef HCSR04_H
#define HCSR04_H
#include "common.h"
/* define trigger and echo pins for the two sensors */

#define trig1Pin 19
#define echo1Pin 26
struct gpiod_line *trig1Line;
struct gpiod_line *echo1Line;

#define trig2Pin 13
#define echo2Pin 6

struct gpiod_line *trig2Line;
struct gpiod_line *echo2Line;

#endif
