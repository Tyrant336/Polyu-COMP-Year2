public class Mergesort {
    int[] Mergesort(int[] a, int low, int mid, int high)
    {
    int[] b = new int[mid- low + 1];
    int[] c = new int[high- mid];
    for (int i=0; i<=mid-low; i++) b[i]=a[low+i];
    for (int i=0; i<high-mid; i++) c[i]=a[mid+1+i];
    int i1 = 0, i2 = 0, i = low;
    while (i1 < b.length && i2 < c.length)
        a[i++] = (b[i1] <= c[i2])? b[i1++]:c[i2++];
    while (i1 < b.length) a[i++] = b[i1++];
    while (i2 < c.length) a[i++] = c[i2++];
    return a;
    }
    public static void main(String[] args) {

    }
}
