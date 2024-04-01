#include <string.h>
#include <stdint.h>
#include <stdio.h>

extern void strcopy(char *d, const char *s);

int main()
{
    char srcstr[] = "First string - soure";         
    char dststr[] = "Second string - destination";  
    strcopy(dststr,srcstr);                         
    return 0;
		
}