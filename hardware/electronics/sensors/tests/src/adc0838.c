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
reads out channel 1 - 6 of adc0838 digitizer,
and prints the results on the screen
*/
#include <gpiod.h>
#include <stdio.h>
#include <unistd.h>
#include "digitizers.h"

void abort(){
  gpiod_line_release(csbarline);
  gpiod_line_release(clockline);
  gpiod_line_release(datainline);
  gpiod_line_release(dataoutline);
  gpiod_line_release(sarsline);
  exit(0);
}

void init_hardware()
{
  openChip();
  dataoutline  = setAsInput(dataOutPin);
  sarsline  = setAsInput(sarsPin);
  datainline   = setAsOutput(dataInPin);
  clockline = setAsOutput(clockPin);
  csbarline = setAsOutput(csbarPin);
}

void select_channel(unsigned int num)
{
  /* num is the number of the channel to be read out */
  int odd  = (num & (1u << 0) ? HIGH : LOW);
  int bit0 = (num & (1u << 1) ? HIGH : LOW);
  int bit1 = (num & (1u << 2) ? HIGH : LOW);
  /* write start bit */
  writeState(clockline, LOW);
  writeState(datainline, HIGH);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  /* write SGL should be one */
  writeState(datainline, HIGH);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  /* write Odd/sign bit */
  writeState(datainline, odd);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  /* write bit 1 */
  writeState(datainline, bit1);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
  /* write bit 0 */
  writeState(datainline, bit0);
  writeState(clockline, HIGH);
  writeState(clockline, LOW);
}

int read_channel(unsigned int num){
  /* enable chip */
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
    k = k/2;
  };
  /* disable ADC chip */
  writeState(csbarline, HIGH);
  return out;
}

int main(int argc, char **argv)
{
  int sensors[6];
  /* initialise the hardware */
  init_hardware();
  writeState(csbarline, HIGH);
  writeState(clockline, LOW);
  while (1) {
    for (int channel=0;channel<6;channel++){
      sensors[channel] = read_channel(channel);
    }
    printf("Pressure sensor readings: %d %d %d %d %d %d\n",
           sensors[0], sensors[1], sensors[2], sensors[3], sensors[4], sensors[5]);
    delay(1);
  }
}
