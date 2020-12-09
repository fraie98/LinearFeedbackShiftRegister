#include<iostream>

using namespace std;

const int N = 16;

int xorFunction(int a, int b)
{
	if(a==0 && b==0)
		return 0;

	if(a==0 && b==1)
		return 1;

	if(a==1 && b==0)
		return 1;

	if(a==1 && b==1)
		return 0;
	return 0;
} 

bool compare(int a[N], int b[N])
{
	for(int i = 0; i<N; i++)
	{
		if(a[i]!=b[i])
			return false;
	}

	return true;
}

void printLFSR(int a[N])
{
	for (int i = 0; i < N; i++)
	{
		cout << a[i];
	}
}



bool isTap(int i)
{
	if(i==11 || i == 13 || i== 14)
		return true;
	
	return false;
}

int main()
{
	int seed[N] = {0,0,1,0,0,0,0,0,0,1,0,1,0,1,0,1};
	int actual_state[N];


	for(int i = 0; i<N; i++)
		actual_state[i]=seed[i];
	

	cout << " Initial Situation:" << endl;
	printLFSR(actual_state);
	cout <<"\n";
	printLFSR(seed);
	cout <<"\n";
	//int count = 0;
	do
	{
		int lastBit = actual_state[N-1];
		int temp[N];
		for(int i = 0; i<N; i++)
		{
			if(i!=0 && isTap(i-1))
				temp[i] = xorFunction(actual_state[i-1],lastBit);
			else if(i==0)
				temp[i] = lastBit;
			else
				temp[i] = actual_state[i-1];
		}

		for(int i = 0; i<N; i++)
			actual_state[i]=temp[i];

		printLFSR(actual_state);
		cout << " \tOutput is: " << lastBit << endl;
		//count++;
	//}while(count<10);
	}while(!compare(actual_state,seed));

	return 0;
}