/*
 * Program test for VHDL implementation of LFSR.
 * Francesco Iemma
 */

#include<iostream>

using namespace std;

// Length of the LFSR
const int N = 16;

/*
 * XOR function implementation
 */
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

/*
 * Return true if the two state are equal
 */
bool compare(int a[N], int b[N])
{
	for(int i = 0; i<N; i++)
	{
		if(a[i]!=b[i])
			return false;
	}

	return true;
}

/*
 * Print the state of the LFSR
 */
void printLFSR(int a[N])
{
	for (int i = 0; i < N; i++)
	{
		cout << a[i];
	}
}

/*
 * Return true if the i-th bit is a tap,
 * false otherwise
 */
bool isTap(int i)
{
	if(i==10 || i == 12 || i== 13)
		return true;
	
	return false;
}

int main()
{
	// Initialization value
	int seed[N] = {0,0,1,0,0,0,0,0,0,1,0,1,0,1,0,1};
	// Actual state of the LFSR
	int actual_state[N];
	// Reset Phase: actual state is initialized to the seed value
	for(int i = 0; i<N; i++)
		actual_state[i] = seed[i];

	/* It's necessary because at the first clock
	 * the output will be undefined*/		
	cout << "U" << endl;

	do
	{
		// Feedback bit
		int lastBit = actual_state[N-1];
		// Next LFSR state
		int next_state[N];
		// Shift operation
		for(int i = 0; i<N; i++)
		{
			if(i!=0 && isTap(i-1))
				next_state[i] = xorFunction(actual_state[i-1],lastBit);
			else if(i==0)
				next_state[i] = lastBit;
			else
				next_state[i] = actual_state[i-1];
		}

		// The next state became the actual state
		for(int i = 0; i<N; i++)
			actual_state[i] = next_state[i];

		// Print the output
		cout << lastBit << endl;
	}while(!compare(actual_state,seed));

	return 0;
}