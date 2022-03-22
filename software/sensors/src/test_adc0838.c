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
#include <stdio.h>
#include <unistd.h>
#include "adc0838.h"

int main(int argc, char **argv)
{
  int sensors[channels];
  /* initialise the hardware */
  init_adc0838();
  while (1) {
    adc0838(sensors);
    printf("Pressure sensor readings: %d %d %d %d %d %d\n",
           sensors[0], sensors[1], sensors[2], sensors[3], sensors[4], sensors[5]);
    (void) sleep(1);
  }
}
