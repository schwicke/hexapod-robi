#ifndef DIGITIZER_H
#define DIGITIZER_H
#include "common.h"
#include "adc0838.h"

/* define the pins used to read out the digitizers*/
#define csbarPin 16
#define clockPin 12
#define dataOutPin 20
#define dataInPin 21
#define sarsPin 15

/* define the corresponding lines */
struct gpiod_line *csbarline;
struct gpiod_line *dataoutline;
struct gpiod_line *datainline;
struct gpiod_line *clockline;
struct gpiod_line *sarsline;

#endif
