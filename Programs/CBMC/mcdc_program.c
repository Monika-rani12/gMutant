#include<stdio.h>
int main()
{
int X = nondet_int(); __CPROVER_input("X",X);
int Y = nondet_int(); __CPROVER_input("Y",Y);
int Z = nondet_int(); __CPROVER_input("Z",Z);
if (((X > 20) && (Y == 30)) || (Z < 40)) {
printf("This is sample program\n");
}

return 0;
}
