#ifndef ADC0838_H
#define ADC0838_H

/* number of channels */
#define channels 6

/* initialise the chip */
void init_adc0838();

/* get new readings */
void adc0838(int sensors[]);

#endif
