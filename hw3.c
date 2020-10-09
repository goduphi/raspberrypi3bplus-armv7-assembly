#include <stdio.h>
#include <stdint.h>


typedef struct _BUSINESS3
{
	uint8_t taxId;
	uint32_t name;
	char street[34];
	char direction;
	uint32_t addNo;
	char city[40];
	char state[3];
	uint32_t zip;
} BUSINESS3;

extern int32_t sumS32(const int32_t x[], int32_t count);
extern uint64_t sumU32_64(const uint32_t x[], uint32_t count);
extern uint32_t countNegative(const int32_t x[], uint32_t count);
extern void leftStringFull(char strOut[], const char strIn[], uint32_t length);
extern void leftStringTrunc(char strOut[], const char strIn[], uint32_t length);
extern uint32_t countMatches(const char strIn[], const char strMatch[]);
extern int32_t find2ndMatch(const char strIn[], const char strMatch[]);
extern void sortDecendingInPlace(int32_t x[], uint32_t count);
extern int8_t decimalStringToInt8(const char str[]);
extern uint32_t hexStringToUint32(const char str[]);
extern void uint8ToBinaryString(char str[], uint8_t x);
extern int32_t findStreet(char street[], const BUSINESS3 business[], uint32_t count);



int main(void)
{
	int32_t MyArr[] = {1,-6,-7,8,5};
	printf("sumS32 = %d\n", sumS32(MyArr, 5));
	
	uint32_t x[] = {4294967295, 4294967295, 4294967295};
	printf("sumU32_64 = %llu\n", sumU32_64(x, 3));
	
	printf("countNegative = %u\n", countNegative(MyArr, 3));
	
	char mString[45] = "This is a strng";
	char outputArr[45];
	
	leftStringFull(outputArr, mString, 11);
	
	printf("leftStringFull = %s\n", outputArr);
	
	leftStringTrunc(outputArr, mString, 45);
	
	printf("leftStringTrunc = %s\n", outputArr);
	
	char chMatch[100] = "l";
	
	printf("countMatches = %u\n", countMatches(mString, "is"));
	
	printf("find2ndMatch = %d\n", find2ndMatch(mString, "is"));
	
	sortDecendingInPlace(MyArr, 5);
	
	int i = 0;
	
	for(i = 0; i < 5; i++)
		printf("%d\t", MyArr[i]);
	
	printf("\n");
	
	printf("%d\n", decimalStringToInt8("-45"));
	
	printf("%08x\n", hexStringToUint32("12AF"));
	
	uint8ToBinaryString(chMatch, 127);
	
	printf("%s\n", chMatch);
	
	BUSINESS3 business[3] = {{12342332, "Home Depot", "Road to Six Flags", 'W', 201, "Arlington", "TX", 76011},
							 {456465, "HSasd", "x", 'W', 201, "Arlington", "TX", 76011},
							 {456465, "HSasd", "y", 'W', 201, "Arlington", "TX", 76011}};
	printf("Addresses of selected record entries:\r\n");
    char format[] = {"%p %s\r\n"};
    printf(format, &business[0], "business[0]");
    printf(format, &business[0].taxId, "taxId");
    printf(format, &business[0].name, "name");
    printf(format, &business[0].street, "stree");
    printf(format, &business[0].direction, "direction");
    printf(format, &business[0].addNo, "street");
    printf(format, &business[0].city, "city");
    printf(format, &business[0].state, "state");
    printf(format, &business[0].zip, "zip");
    printf(format, &business[1], "business[1]");
    printf(format, &business[2], "business[2]");
	int32_t street = findStreet("y", business, 3);
	printf("%d\n", street);
	
	uint32_t hex = hexStringToUint32("12AF");
	printf("%d\n", hex);
	
	return 0;
}
