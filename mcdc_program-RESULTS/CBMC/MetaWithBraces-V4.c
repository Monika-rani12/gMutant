#include<stdio.h>
int main()
{
int X, Y, Z;
scanf("%d",&X); 
scanf("%d",&Y); 
scanf("%d",&Z); 
if ((!(((X > 50) && (Y == 100)) || (Z < 90)))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("PNF KILLED at %d \n ",__LINE__);}
if ( (((!(X > 50 )) && (Y == 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("CNF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (!( Y == 100 ))) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("CNF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y == 100)) || (!( Z < 90)))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("CNF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y != 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y < 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y > 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y <= 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y >= 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y == 100)) && (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("LOF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y == 100)) || (Z != 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y == 100)) || (Z > 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y == 100)) || (Z <= 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y == 100)) || (Z >= 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) && (Y == 100)) || (Z == 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X > 50) || (Y == 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("LOF KILLED at %d \n ",__LINE__);}
if ( (((X != 50) && (Y == 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X < 50) && (Y == 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X <= 50) && (Y == 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X >= 50) && (Y == 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}
if ( (((X == 50) && (Y == 100)) || (Z < 90))  != (((X > 50) && (Y == 100)) || (Z < 90))){printf("ROF KILLED at %d \n ",__LINE__);}

if (((X > 50) && (Y == 100)) || (Z < 90)) {
printf("This is sample program\n");
}
X=50;
if((!(X != 50))  != (X != 50)){printf("PNF KILLED at %d \n ",__LINE__);}
if( (X == 50)  != (X != 50)){printf("ROF KILLED at %d \n ",__LINE__);}
if( (X < 50)  != (X != 50)){printf("ROF KILLED at %d \n ",__LINE__);}
if( (X > 50)  != (X != 50)){printf("ROF KILLED at %d \n ",__LINE__);}
if( (X <= 50)  != (X != 50)){printf("ROF KILLED at %d \n ",__LINE__);}
if( (X >= 50)  != (X != 50)){printf("ROF KILLED at %d \n ",__LINE__);}

if(X != 50) {
if(Y==100){
printf("This is not reachable");
}
}
return 0;
}
