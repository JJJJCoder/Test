// 250.cpp : �������̨Ӧ�ó������ڵ㡣
//
#include<iostream>
using namespace std;
int n;
int array[21];
//����
void backtrack(int t);
//�������
bool isPrime(int temp);
//����ǰ����Ƿ���ͬ
bool check(int t);
int main(void)
{
    int count=0;
    while(1)
    {
        cin>>n;
        if(n == 0) break;
        array[1]=1;
        cout<<"Case "<<++count<<":"<<endl;
        backtrack(2);
        cout<<endl;
    }
    return 0;
}
void backtrack(int t)
{
    if(t>n)
    {
        if( isPrime(array[n]+array[1])&&check(n) )
        {
            for(int i=1;i<=n;i++)
            {
                cout<<array[i]<<(i<n?' ':'\n');
            }
        }
    }
    else
    {
        for(int i=2;i<=n;i++)
        {
            array[t]=i;
            if( isPrime(array[t]+array[t-1])&&check(t) )
            {
                backtrack(t+1);
            }
        }
    }
}
bool isPrime(int n)
{
    for(int i=2;i<=n/2;i++)
    {
        if(n%i==0)
        {
            return false;
        }
    }
    return true;
}
bool check(int t)
{
    for(int i=1;i<t;i++)
    {
        if(array[i]==array[t])
        {
            return false;
        }
    }
    return true;
}