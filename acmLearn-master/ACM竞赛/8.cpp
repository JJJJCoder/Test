#include <stdio.h>
#include <math.h>
int main()
{
	int HJ=0;
	for(int i=0;i<16;i++) // 16=2^4 : (0 0 0 0)~~(1 1 1 1) ��ȫ����
	{  
		int A=1000,B=2000;
		for(int j=0;j<4;j++) // ��Ϊ4�غ��ж�һ��,��4��һ�� ����(0 1 0 1)�ɱ�ʾΪA(ʧ�� ʤ�� ʧ�� ʤ��)  
		{	   
			if(i&(1<<j))
			{	   
				A+=B/4;
				B-=B/4;
			}
			else
			{
				B+=A/4;
				A-=A/4;
			}
		}
		if(abs(A-B)>=1000)
			HJ++; 
	}
	printf("%.3f\n",HJ*pow(0.5,4));
	return 0;   
}
