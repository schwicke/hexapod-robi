bin_PROGRAMS = test_adc0838 test_hcsr04 test_mpu6050

test_adc0838_SOURCES = common.c adc0838.c test_adc0838.c
test_adc0838_LDADD = -lgpiod

test_hcsr04_SOURCES = common.c hcsr04.c test_hcsr04.c 
test_hcsr04_LDADD = -lgpiod

test_mpu6050_SOURCES = mpu6050.c test_mpu6050.c
test_mpu6050_LDADD = -lm -li2c
