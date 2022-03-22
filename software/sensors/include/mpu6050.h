/* read out mpu6050 */
#ifndef MPU6050_H
#define MPU6050_H
#include <stdlib.h>

/* initialise the board */
int init_mpu6050();

/* get new readings */
void mpu6050(int fd, int16_t gyr[3], double acc[3], double rot[2]);
#endif
