public class recursiveselectionsort {
    void recursiveSelection(int[] a, int begin) 
    {
        if (begin == a.length- 1) return;
        int n = a.length;
        int min = begin;
        for (int i = begin+1; i < n; i++)
            if (a[min] > a[i]) min = i;
            {
                swap(a, begin, min);
                recursiveSelection(a, begin+1);
            }
    }
}
