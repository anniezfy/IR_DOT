#include<stdio.h>
#include<stdlib.h>
float add_function(float, float);

int main(int argc, char* argv[]) {
  // check for correctness
  float p0 = atof(argv[1]);
  float p1 = atof(argv[2]);
  float r = add_function(p0, p1);
  printf("%f\n", r);
  return 0;
}