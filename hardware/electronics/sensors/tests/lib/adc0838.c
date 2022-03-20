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
#include "digitizers.h"

void abort(){
  gpiod_line_release(csbarline);
  gpiod_line_release(clockline);
  gpiod_line_release(datainline);
  gpiod_line_release(dataoutline);
  gpiod_line_release(sarsline);
  exit(0);
}

void init_adc0838()
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

void adc0838(int sensors[]){
  writeState(csbarline, HIGH);
  writeState(clockline, LOW);
  for (int channel=0; channel<channels; channel++){
    sensors[channel] = read_channel(channel);
  }
}

