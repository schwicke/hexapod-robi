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
#include "hcsr04.h"
#include "mpu6050.h"

int main(int argc, char **argv)
{
  int sensors[channels];
  /* initialise the hardware */
  int fd;
  int16_t gyr[3];
  double acc[3];
  double rot[2];
  float dist[2];
  /* initialise the sensor boards */
  fd = init_mpu6050();
  init_adc0838();
  init_hcsr04();
  while (1) {
    /* get fresh data */
    adc0838(sensors);
    hcsr04(dist);
    mpu6050(fd, gyr, acc, rot);
    /* for now simply print out the readings */
    printf("Gyroscop     %d %d %d\n", gyr[0], gyr[1], gyr[2]);
    printf("Acceleration %f.2 %f.2 %f.2\n", acc[0], acc[1], acc[2]);
    printf("Rotation     %f.2 %f.2\n", rot[0], rot[1]);
    printf("The distances are : %.2f cm and %.2f cm\n", dist[0], dist[1]);
    printf("Pressure sensor readings: %d %d %d %d %d %d\n",
           sensors[0], sensors[1], sensors[2], sensors[3], sensors[4], sensors[5]);
    (void) sleep(1);
  }
}
