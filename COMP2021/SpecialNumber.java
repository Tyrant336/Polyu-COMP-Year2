package hk.edu.polyu.comp.comp2021.assignment1;

public class SpecialNumber {

	public static boolean isSpecial(int num) {
		if(num <=1) return false;

		int cout = 0;

		if(num%2 == 0)
		{
			cout++;
			while(num%2 ==0)
			{
				num/=2;
			}
		}
		for(int i = 3; i*i <= num; i+= 2)
		{
			if(num %i ==0)
			{
				cout++;
				while(num%i ==0)
				{
					num /=i;
				}
			}
		}
		if(num > 1)
		{
			cout++;
		}
		return cout == 3;
	}

}
