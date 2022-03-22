/* common definitions */
#ifndef COMMON_H
#define COMMON_H
#include <gpiod.h>

/* for libgpiod */
#ifndef CONSUMER
#define CONSUMER        "Consumer"
#endif

/* define constance */
#define LOW 0
#define HIGH 0xffffff

/* common prototypes */
void delay(int delay);
void delayMicroseconds(int delay);

/* define as input or output */
struct gpiod_line * setAsOutput(int pin);
struct gpiod_line * setAsInput(int pin);

void openChip();
/* Input/Output routines */
int readState(struct gpiod_line *line);
void writeState(struct gpiod_line *line, unsigned int state);

#endif
