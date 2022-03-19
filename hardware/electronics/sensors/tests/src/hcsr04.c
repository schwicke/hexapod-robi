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
#include <gpiod.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include "distsensors.h"

void init_hcsr04()
{
  openChip();
  trig1Line  = setAsOutput(trig1Pin);
  echo1Line  = setAsInput(echo1Pin);
  trig2Line  = setAsOutput(trig2Pin);
  echo2Line  = setAsInput(echo2Pin);
}

float getDistance(struct gpiod_line * trigLine, struct gpiod_line * echoLine){
  struct timeval t0, tb, te;
  long micros;
  float distance;

  micros = 0;
  gettimeofday(&t0, NULL);
  gettimeofday(&tb, NULL);
  gettimeofday(&te, NULL);
  writeState(trigLine, HIGH); //send 10us high level to trigPin
  delayMicroseconds(10);
  writeState(trigLine, LOW);
  micros = 0;
  while (readState(echoLine) == 0)
    {
      gettimeofday(&tb, NULL);
      if ((tb.tv_sec-t0.tv_sec) > 1)
        {
          return -1;
        }
    };
  while (readState(echoLine) )
    {
      gettimeofday(&te, NULL);
      if ((te.tv_sec-t0.tv_sec) > 1)
        {
          return -1;
        }
    };
  micros = te.tv_usec-tb.tv_usec;
  distance = (float)micros/10000.0 * 343.0 / 2.0 ; //calculate distance with sound speed 340m/s
  return distance;
}

void hcsr04(float dist[]){
  writeState(trig1Line, LOW);
  writeState(trig2Line, LOW);
  dist[0] = getDistance(trig1Line, echo1Line);
  dist[1] = getDistance(trig2Line, echo2Line);
}

