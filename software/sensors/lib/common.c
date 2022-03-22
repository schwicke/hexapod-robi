/*
This file is part of the hexapod-robi distribution (https://github.com/schwicke/hexapod-robi).
Copyright (c) 2021 Ulrich Schwickerath

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, version 3.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
#include <gpiod.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include "common.h"

/* pointer to the gpio chip structure */
struct gpiod_chip *chip;


void delay(int delay){
  /* sleep in milliseconds */
  sleep((float)delay/1e3);
}

void delayMicroseconds(int delay){
  /* sleep in microseconds */
  sleep((float)delay/1e6);
}

struct gpiod_line * setAsOutput(int pin){
  /* set pin number as output */
  struct gpiod_line *gpio_line;
  int result;

  gpio_line = gpiod_chip_get_line(chip, pin);
  if (!gpio_line) {
    gpiod_chip_close(chip);
    perror("Get line failed\n");
    exit(1);
  }
  result = gpiod_line_request_output(gpio_line, CONSUMER, 0);
  if (result < 0) {
    perror("Request line as output failed\n");
    abort();
  }
  return(gpio_line);
}

struct gpiod_line * setAsInput(int pin){
  /* set pin number as input */
  struct gpiod_line *gpio_line;
  int result;

  gpio_line = gpiod_chip_get_line(chip, pin);
  if (!gpio_line) {
    gpiod_chip_close(chip);
    perror("Get line failed\n");
    exit(1);
  }
  result = gpiod_line_request_input(gpio_line, CONSUMER);
  if (result < 0) {
    perror("Request line as input failed\n");
    abort();
  }
  return(gpio_line);
}

void openChip()
/* open the gpio chip */
{
  char *chipname = "gpiochip0";
  /* open the chip */
  chip = gpiod_chip_open_by_name(chipname);
  if (!chip) {
    perror("Open chip failed\n");
    exit(1);
  }
}

int readState(struct gpiod_line *line){
  /* read from line */
  return( gpiod_line_get_value(line));
}

void writeState(struct gpiod_line *line, unsigned int state){
  /* write to line */
  int result;
  result = gpiod_line_set_value(line, state);
  if (result < 0){
    perror("Set line output failed\n");
    abort();
  }
  delay(10);
}

