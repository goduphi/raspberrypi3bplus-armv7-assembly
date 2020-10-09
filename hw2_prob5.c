#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

extern uint64_t add64(uint64_t x, uint64_t y);
extern uint64_t sub64(uint64_t x, uint64_t y);
extern uint16_t minU8(uint8_t x, uint8_t y);
extern int16_t minS8(int8_t x, int8_t y);
extern bool isLessThanU32(uint32_t x, uint32_t y);
extern bool isLessThanS32(int32_t x, int32_t y);
extern uint32_t shiftLeftU32(uint32_t x, uint32_t p);
extern uint32_t shiftU32(uint32_t x, int32_t p);
extern int32_t shiftS32(int32_t x, int32_t p);
extern bool isEqualU16(uint16_t x, uint16_t y);
extern bool isEqualS16(int16_t x, int16_t y);
extern void strCopy(char* strTo, char* strFrom);
extern void strConcat(char* strTo, char* strFrom);

int main(void)
{
	uint64_t z = add64(10000000000, 20000500000);
	printf("----------------------\n%llu\n", z);
	uint64_t z1 = sub64(30000000000, 20000500000);
	printf("----------------------\n%llu\n", z1);
	uint16_t z2 = minU8(255, 4);
	printf("----------------------\n%u\n", z2);
	int16_t z3 = minS8(-120, 4);
	printf("----------------------\n%d\n", z3);
	printf("----------------------\n%u\n", isLessThanU32(5, 9));
	printf("----------------------\n%d\n", isLessThanS32(-4, -24));
	printf("----------------------\n%u\n", shiftLeftU32(10, 2));
	printf("----------------------\n%u\n", shiftU32(256, -4));
	printf("----------------------\n%d\n", shiftS32(-256, -2));
	printf("----------------------\n%d\n", isEqualU16(70, 70));
	printf("----------------------\n%d\n", isEqualS16(-70, -70));
	char strFrom[] = "Tasin tr maireh ami aunty daki! Showvik fucks Sujey!";
	char strTo[1000];
	strCopy(strTo, strFrom);
	printf("----------------------\n%s\n", strTo);
	char strTo1[10000] = "Khanki magi hala.";
	strConcat(strTo1, strFrom);
	printf("----------------------\n%s\n", strTo1);
	return EXIT_SUCCESS;
}