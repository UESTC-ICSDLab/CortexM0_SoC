#include <string.h>
#include <stdint.h>
#include <stdio.h>
extern void f();
int main()
{
	f();
	return 0;
}

int g(int a, int b, int c, int d)
{
	return a + b + c +d;
}
