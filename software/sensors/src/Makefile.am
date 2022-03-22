bin_PROGRAMS = sensors

sensors_CPPFLAGS = -I$(top_srcdir)/include
sensors_SOURCES = sensors.c
sensors_LDADD = -L$(top_srcdir)/lib -lmbot_sensors -lgpiod -lm -li2c
