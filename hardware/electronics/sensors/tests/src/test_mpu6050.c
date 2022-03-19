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
#include "mpu6050.h"

int main(int argc, char *argv[])
{
    int fd;
    int16_t gyr[3];
    double acc[3];
    double rot[2];
    fd = init_mpu6050();
    while (1) {
      mpu6050(fd, gyr, acc, rot);
      printf("Gyroscop     %d %d %d\n", gyr[0], gyr[1], gyr[2]);
      printf("Acceleration %f.2 %f.2 %f.2\n", acc[0], acc[1], acc[2]);
      printf("Rotation     %f.2 %f.2\n", rot[0], rot[1]);
    }
}
