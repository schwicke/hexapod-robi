#include <gpiod.h>
struct gpiod_chip *chip;
struct gpiod_line *csbarline;
struct gpiod_line *dataoutline;
struct gpiod_line *datainline;
struct gpiod_line *clockline;
struct gpiod_line *sarsline;

#define csbarPin 16
#define clockPin 12
#define dataOutPin 20
#define dataInPin 21
#define sarsPin 15
