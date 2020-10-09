#include <stdio.h>
#include <stdint.h>

extern float sumF32(const float x[], uint32_t count);
extern double prodF64(const double x[], uint32_t count);
extern double dotpF64(const double x[], const double y[], uint32_t count);
extern float maxF32(const float x[], uint32_t count);

#define COUNT 5

int main(void)
{
	float x[COUNT] = {5.987, 100.12321425325,4.65,78.5};
	double y[COUNT] = {1.2, 2.4, 5.6};
	float result;
	result = maxF32(x, 0);
	printf("result = %f\r\n", result);
	return 0;
}