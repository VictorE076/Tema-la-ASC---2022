#include <iostream>
#include <fstream>
using namespace std;
ifstream f("input3.txt");
void matrix_mult(int m1[100][100], int m2[100][100], int mres[100][100], int n)
{
	int a;
	int b;
	int c;
	int vl;
	
	for(a = 0; a < n; a++)
	{
		for(b = 0; b < n; b++)
		{
			vl = 0;
			for(c = 0; c < n; c++)
			{
				vl += m1[a][c] * m2[c][b];
			}
			mres[a][b] = vl;
		}
	}
	return;
}
int main()
{
	int nr;
	int n;
	int Mi[100];
	int m1[100][100];
	int m2[100][100];
	int mres[100][100];
	int x;
	int ii;
	int jj;
	
	int k;
	int i;
	int j;
	
	
	f >> nr;
	f >> n;
	
	///
	for(ii = 0; ii < n; ii++)
	{
		for(jj = 0; jj < n; jj++)
		{
			m1[ii][jj] = 0;
			m2[ii][jj] = 0;
			mres[ii][jj] = 0;
		}
	}
	///
	

	for(ii = 0; ii < n; ii++)
	{
		f >> x;
		Mi[ii] = x;
		// cout << Mi[ii] << " ";
	}
	// cout << endl;
	
	for(ii = 0; ii < n; ii++)
	{
		for(jj = 0; jj < Mi[ii]; jj++)
		{
			f >> x;
			m1[ii][x] = 1;
		}
	}
	
	if(nr == 1)
	{
		for(ii = 0; ii < n; ii++)
		{
			for(jj = 0; jj < n; jj++)
			{
				cout << m1[ii][jj] << " ";
			}
			cout << endl;
		}
	}
	else
	if(nr == 2)
	{
		f >> k;
		f >> i;
		f >> j;
		
		
		for(ii = 0; ii < n; ii++)
		{
			for(jj = 0; jj < n; jj++)
			{
				x = m1[ii][jj];
				m2[ii][jj] = x;
			}
		}
		
		
		while(k > 1)
		{
			matrix_mult(m1, m2, mres, n);
			
			for(ii = 0; ii < n; ii++)
			{
				for(jj = 0; jj < n; jj++)
				{
					x = mres[ii][jj];
					m1[ii][jj] = x;
					
					cout << m1[ii][jj] << " ";//
				}
				cout << endl;//
			}
			cout << endl;//
			
			k--;
		}
		
		x = m1[i][j];
		cout << x << endl;
	}
	
	f.close();
	return 0;
}
