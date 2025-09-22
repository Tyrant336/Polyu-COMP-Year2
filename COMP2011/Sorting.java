

import java.security.SecureRandom;
import java.util.Arrays;

/**
 * 
 * @author Yixin Cao (September 11, 2025)
 *
 * Sorting algorithms, file 1.
 * Three basic sorting algorithms.
 *
 * We'll see more sorting algorithms later on.
 *
 * See https://www.geeksforgeeks.org/assertions-in-java/ for more information on "Assertions in Java."
 */
public class Sorting {

    public static void selectionSort(int[] a) {
        for(int i = 0; i < a.length; i++)
        {
            int max = i;
            for(int j = i; j < a.length; j++)
            {
                if(a[j] > a[max])
                {
                    max = j;
                }
            }
            int temp = a[max];
            a[max] = a[i];
            a[i] = temp;
        }
    }

    public static void insertionSort(int[] a) {
        for(int i = 0; i < a.length - 1; i++)
        {
            int key = a[i];
            int j = i - 1;
            while(j>= 0 && a[j] > key)
            {
                a[j+ 1] =a[j];
                j--;
            }
            a[j+1] = key;
        }
    }

    public static void bubbleSort(int[] a) {
        throw new UnsupportedOperationException("Not implemented yet");
    }

     /*
     * Two methods for checking whether the array is sorted.
     *
     * Version 1 returns yes/no.
     * Version 2 returns the first index i with a[i] > a[i+1] (-1 if sorted).
     */
    private static boolean sorted(int[] a) {	
	for (int i = 0; i < a.length - 1; i++)
	    if (a[i+1] < a[i]) return false;
	return true;
    }
    private static int wrongPair(int[] a) {
	for (int i = 0; i < a.length - 1; i++)
	    if (a[i+1] < a[i]) return i;
	return -1;
    }
   public static void test(int n) {
        long startTime = 0;
        double duration = 0;

        int[] a = new int[n];
        int[] b = new int[n];
        SecureRandom random = new SecureRandom();
        for (int i = 0; i < n; i++)
            a[i] = random.nextInt(n);

        System.out.println("n = " + n);
        for (int i = 0; i < n; i++)
            b[i] = a[i];
        startTime = System.currentTimeMillis();
        insertionSort(b);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        assert sorted(b);
        assert wrongPair(b) < 0 : Arrays.toString(b);
        System.out.println("insertionSort takes " + (duration) + " seconds.");

        for (int i = 0; i < n; i++)
            b[i] = a[i];
        startTime = System.currentTimeMillis();
        bubbleSort(b);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        assert sorted(b);
        assert wrongPair(b) < 0 : Arrays.toString(b);
        System.out.println("bubbleSort takes " + (duration) + " seconds.");

        for (int i = 0; i < n; i++)
            b[i] = a[i];
        startTime = System.currentTimeMillis();
        selectionSort(b);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        assert sorted(b);
        assert wrongPair(b) < 0 : Arrays.toString(b);
        System.out.println("selectionSort takes " + duration + " seconds.");

        // quit after it becomes too slow
        if (duration > 1800)
            System.exit(0);

        for (int i = 0; i < n; i++)
            b[i] = a[i];
        startTime = System.currentTimeMillis();
        Arrays.sort(b);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        assert sorted(b);
        assert wrongPair(b) < 0 : Arrays.toString(b);
        System.out.println("sort of Java takes... " + duration + " seconds.\n\n");

        /*
         * // you can use the following to try theor performance on an
         * increasingly ordered array, for (int j = 0; j < turns; j++ ) {
         * for(int i = 0; i < size; i++) b[i] = i; insertionSort(b); } // or an
         * decreasingly ordered array; for (int j = 0; j < turns; j++ ) {
         * for(int i = 0; i < size; i++) b[i] = size - i; insertionSort(b); }
         */
    }

    public static void main(String[] args) {
        int n = 16384; // 2^14
        while (true) {
            test(n);
            n = n * 7 /5;
        }
    }
}