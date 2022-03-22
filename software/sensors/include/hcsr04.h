#ifndef HCSR04_H
#define HCSR04_H

/* initialize the hardware */
void init_hcsr04();

/* get fresh data from the sensor boards */
void hcsr04(float dist[]);

#endif
