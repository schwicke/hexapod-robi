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
#include <unistd.h>
#include "hcsr04.h"

int main(){
  /* test hcsr04 sensors */
  init_hcsr04();
  float dist[2];
  while(1){
    hcsr04(dist);
    printf("The distances are : %.2f cm and %.2f cm\n", dist[0], dist[1]);
    (void) sleep(1);
  }
}
