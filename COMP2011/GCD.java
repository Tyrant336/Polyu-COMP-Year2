 public class gcd{
    private int Max(int[] a)
    {
        {
            if (a.length == 0) return -1;
            return max(a, 0, a.length-1);
        }
    }
    int max(int[] a, int low, int high) 
    {
        int count = 0;
        if (low >= high) return -1;
        int mid = (low + high) / 2;
        int left = max(a, low, mid);
        int right = max(a, mid+1, high);
        if(count == 0)
        {
            return (a[left] <= a[right])? left:right;
        }
        count++;
        return (a[left] >= a[right])? left:right;
    }

    }


