
#include <stdio.h>
#include<string.h>                                    //Ҫ�õ�string.hͷ�ļ��к���
int main()
{
	int i;
	char a[20]="MMM",b[200],c[10];
	while(1)                //����ѭ������
	{
		gets(a);
        if(strcmp(a,"ENDOFINPUT")==0)break;
		gets(b);
		gets(c);                                     //���������ַ�����Ϣ
		for(i=0;b[i]!='\0';i++)
		{
			if(b[i]==' '||b[i]==',')continue;               //���Ϊ�ո���߶���������
			if(b[i]>=65&&b[i]<70){b[i]+=21; continue;}
			if(b[i]>69&&b[i]<91){b[i]-=5;continue;}             //��һ����Χ�ڽ���
		}
		printf("%s\n",b);                             //���ԭ��
	}
	return 0;
}

