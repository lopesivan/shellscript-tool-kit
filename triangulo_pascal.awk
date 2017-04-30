#! /usr/bin/awk -f

{
	for(i=0;i<$1;i++)
	{
		c=1;r=c;
		for(j=0;j<i;j++)
		{
			c*=(i-j)/(j+1);
			r=r" "c
		};
		print r
	}
}
