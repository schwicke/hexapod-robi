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

double dist(double x, double y){
  return (sqrt(x*x+y*y));
}

double rad2grad(double x){
  return(360.0/(4.0*asin(1))*x);
}

double get_y_rotation(double x, double y, double z){
  return(atan2(x, dist(y,z)));
}
  
double get_x_rotation(double x, double y, double z) {
  return(atan2(y, dist(x,z)));
}

int main(int argc, char *argv[])
{
    int fd;
    fd = open("/dev/i2c-1", O_RDWR);
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
    while (1) {
      /* gyroscope */
      int16_t gyroscop_xout = i2c_smbus_read_byte_data(fd, 0x43) << 8 | i2c_smbus_read_byte_data(fd, 0x44);
      int16_t gyroscop_yout = i2c_smbus_read_byte_data(fd, 0x45) << 8 | i2c_smbus_read_byte_data(fd, 0x46);
      int16_t gyroscop_zout = i2c_smbus_read_byte_data(fd, 0x47) << 8 | i2c_smbus_read_byte_data(fd, 0x48);
      /* acceleration */
      int16_t acc_xout = i2c_smbus_read_byte_data(fd, 0x3b) << 8 | i2c_smbus_read_byte_data(fd, 0x3c);
      int16_t acc_yout = i2c_smbus_read_byte_data(fd, 0x3d) << 8 | i2c_smbus_read_byte_data(fd, 0x3e);
      int16_t acc_zout = i2c_smbus_read_byte_data(fd, 0x3f) << 8 | i2c_smbus_read_byte_data(fd, 0x40);
      /* rotation */
      double rot_x = get_x_rotation((double)acc_xout/16384.0, (double)acc_yout/16384.0, (double)acc_zout/16384.0);
      double rot_y = get_y_rotation((double)acc_xout/16384.0, (double)acc_yout/16384.0, (double)acc_zout/16384.0);
      printf("Gyroscop     %d %d %d\n", gyroscop_xout, gyroscop_yout, gyroscop_zout);
      printf("Acceleration %f.2 %f.2 %f.2\n", acc_xout/16384.0, acc_yout/16384.0, acc_zout/16384.0);
      printf("Rotation     %f.2 %f.2\n", rot_x, rot_y);
    }
}
