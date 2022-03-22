bin_PROGRAMS = test_adc0838 test_hcsr04 test_mpu6050

test_adc0838_CPPFLAGS = -I$(top_srcdir)/include
test_adc0838_SOURCES = test_adc0838.c
test_adc0838_LDADD = -L$(top_srcdir)/lib -lmbot_sensors -lgpiod -lm -li2c

test_hcsr04_CPPFLAGS = -I$(top_srcdir)/include
test_hcsr04_SOURCES = test_hcsr04.c 
test_hcsr04_LDADD = -L$(top_srcdir)/lib -lmbot_sensors -lgpiod -lm -li2c

test_mpu6050_CPPFLAGS = -I$(top_srcdir)/include
test_mpu6050_SOURCES = test_mpu6050.c
test_mpu6050_LDADD = -L$(top_srcdir)/lib -lmbot_sensors -lgpiod -lm -li2c
