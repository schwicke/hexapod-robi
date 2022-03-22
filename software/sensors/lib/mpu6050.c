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
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <time.h>
#include <sys/ioctl.h>
#include "linux/i2c-dev.h"
#include "i2c/smbus.h"

double PI = 4.0*atan(1.0);

double dist(double x, double y){
  return (sqrt(x*x+y*y));
}

double rad2grad(double x){
  return(180.0/PI*x);
}

double get_y_rotation(double accvec[3]){
  double rad = atan2(accvec[0], dist(accvec[1],accvec[2]));
  return(rad2grad(rad));
}
  
double get_x_rotation(double accvec[3]) {
  double rad = atan2(accvec[1], dist(accvec[0], accvec[2]));
  return(rad2grad(rad));
}

int init_mpu6050(){
  int fd = open("/dev/i2c-1", O_RDWR);
  if(fd < 0) {
    fprintf(stderr, "Error opening device\n");
    exit(EXIT_FAILURE);
  }
  if(ioctl(fd, I2C_SLAVE, 0x68) < 0) {
    fprintf(stderr, "Error setting slave address\n");
    close(fd);
    exit(EXIT_FAILURE);
  }
  i2c_smbus_write_byte_data(fd, 0x6b, 0b00000000); // wake the module up
  return(fd);
};

void mpu6050(int fd, int16_t gyr[3], double acc[3], double rot[2]){
  /* gyroscope */
  gyr[0] = i2c_smbus_read_byte_data(fd, 0x43) << 8 | i2c_smbus_read_byte_data(fd, 0x44);
  gyr[1] = i2c_smbus_read_byte_data(fd, 0x45) << 8 | i2c_smbus_read_byte_data(fd, 0x46);
  gyr[2] = i2c_smbus_read_byte_data(fd, 0x47) << 8 | i2c_smbus_read_byte_data(fd, 0x48);
  /* acceleration */
  acc[0] = (double)(i2c_smbus_read_byte_data(fd, 0x3b) << 8 | i2c_smbus_read_byte_data(fd, 0x3c))/16384.0;
  acc[1] = (double)(i2c_smbus_read_byte_data(fd, 0x3d) << 8 | i2c_smbus_read_byte_data(fd, 0x3e))/16384.0;
  acc[2] = (double)(i2c_smbus_read_byte_data(fd, 0x3f) << 8 | i2c_smbus_read_byte_data(fd, 0x40))/16384.0;
  /* rotation */
  rot[0] = get_x_rotation(acc);
  rot[1] = get_y_rotation(acc);
}
