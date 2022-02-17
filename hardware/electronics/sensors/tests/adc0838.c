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

/* Proof of concept for 
reads out channel 1 of adc0838 digitizer, 
and prints the results on the screen
gcc adc0838.c -l gpiod -o adc0838
*/
#include <gpiod.h>
#include <stdio.h>
#include <unistd.h>
#include "digiters.h"

#ifndef	CONSUMER
#define	CONSUMER	"Consumer"
#endif

unsigned int LOW = 0;
unsigned int HIGH = 0xffffff;

void delayMicroseconds(int delay){
  sleep((float)delay/1e6);
}

void delay(int delay){
  sleep((float)delay/1e3);
}

void abort(){
  gpiod_line_release(csbarline);
  gpiod_line_release(clockline);
  gpiod_line_release(datainline);
  gpiod_line_release(dataoutline);
  gpiod_line_release(sarsline);
  exit(0);
}

struct gpiod_line * setAsOutput(int pin){
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

void init_hardware()
{
  char *chipname = "gpiochip0";
  /* open the chip */
  chip = gpiod_chip_open_by_name(chipname);
  if (!chip) {
    perror("Open chip failed\n");
    exit(1);
  }
  dataoutline  = setAsInput(dataOutPin);
  sarsline  = setAsInput(sarsPin);
  datainline   = setAsOutput(dataInPin);
  clockline = setAsOutput(clockPin);
  csbarline = setAsOutput(csbarPin);
}

void writeState(struct gpiod_line *line, unsigned int state){
  int result;
  result = gpiod_line_set_value(line, state);
  if (result < 0){
    perror("Set line output failed\n");
    abort();
  }
  delay(10);
}

int readState(struct gpiod_line *line){
  int result;
  return( gpiod_line_get_value(line));
}

int select_channel(unsigned int num)
{
  // num is the number of the channel to be read out
  int odd = (num & (1u << 0) ? HIGH : LOW);
  int bit1 = (num & (1u << 1) ? HIGH : LOW);
  int bit2 = (num & (1u << 2) ? HIGH : LOW);
  // write start bit
  writeState(clockline, LOW);
  writeState(datainline, HIGH);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  // write SGL should be one
  writeState(datainline, HIGH);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  // write Odd/sign bit
  writeState(datainline, odd);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  // write bit 1
  writeState(datainline, bit1);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  // write bit 2
  writeState(datainline, bit1);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  //while (readState(sarsline) == 0){}
}

int read_channel(unsigned int num){
  // enable chip
  writeState(csbarline, LOW);
  select_channel(num);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  int k = 128;
  int out = 0;
  for (int j=0;j<=7;j++){
    writeState(clockline, HIGH);
    writeState(clockline, LOW);
    int data = readState(dataoutline);
    out = out + k*data;
    //printf("k=%d data=%d out=%d",k, data, out);
    k = k/2;
  };
  // disable chip
  writeState(csbarline, HIGH);
  return out;
}

int main(int argc, char **argv)
{
  int sensors[6];
  // initialise the hardware
  init_hardware();
  writeState(csbarline, HIGH);
  writeState(clockline, LOW);
  while (1) {
    //
    for (int channel=0;channel<2;channel++){
      sensors[channel] = read_channel(channel);
    }
    printf("First two channels: %d %d\n", sensors[0], sensors[1]);
    delay(1);
  }
}
