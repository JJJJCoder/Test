
// 1001(11.12).cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include<stdio.h>
int main()
{
    int a[20],i,m,s = 0,n,b;
while(1)
{
	scanf("%d%d%d",&m,&b,&n);
	if(!n) break;
	s = 0;
	for(i = 0;i < n;i++)
	{
		scanf("%d",&a[i]);
		if(a[i]>m&&a[i]<=b) s += a[i];
	}
	printf("%d\n",s);
}
	return 0;
}



