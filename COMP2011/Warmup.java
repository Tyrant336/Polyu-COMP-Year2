import java.util.Arrays;

public class Warmup {
    /*
     * Find the index of a peak, i.e., an element that is not smaller than its neighbor(s).
     *
     * Example: [10, 20, 15, 2, 23, 90, 45, 67] -> any of 1(20), 5 (90), and 7 (67).
     */
    public static int peak(int[] a) {
        if (a == null || a.length == 0) return -1;
        for (int i = 0; i < a.length; i++) {
            boolean l = (i == 0) || (a[i] >= a[i - 1]);
            boolean r = (i == a.length - 1) || (a[i] >= a[i + 1]);
            
            if (l && r) {
                return i;
            }
        }
        return -1;
    }

    /*
     * Find the indices of a maximum element and a minimum element simultaneously.
     */
    public static int[] maxmin(int[] a) {
        if (a == null || a.length == 0) return new int[]{-1, -1};
        
        int maxIndex = 0;
        int minIndex = 0;
        
        for (int i = 1; i < a.length; i++) {
            if (a[i] > a[maxIndex]) {
                maxIndex = i;
            }
            if (a[i] < a[minIndex]) {
                minIndex = i;
            }
        }
        return new int[]{maxIndex, minIndex};
    }
    
    /**
     * Find the index of one of the second largest elements.
     */
    public static int second(int[] a) {
        if (a == null || a.length < 2) return -1;
        
        int first = 0;
        int second = -1;
        
        for (int i = 1; i < a.length; i++) {
            if (a[i] > a[first]) {
                second = first;
                first = i;
            } else if (second == -1 || a[i] > a[second]) {
                if (a[i] != a[first]) {
                    second = i;
                }
            }
        }
        
        // Handle case where all elements are equal
        if (second == -1) return 0;
        return second;
    }
    
    /**
     * Count inversions in an array.
     */
    public static int inversion(int[] a) {
        if (a == null) return 0;
        int count = 0;
        for (int i = 0; i < a.length; i++)
            for (int j = i + 1; j < a.length; j++)
                if (a[i] > a[j]) count++;
        return count;
    }

    /*
     * Finding the index of a maximum element by divide and conquer.
     */
    public static int max(int[] a) {
        if (a == null || a.length == 0) return -1;
        return max(a, 0, a.length-1);
    }
    
    private static int max(int[] a, int low, int high) {
        if (low >= high) return low;
        int mid = low + (high - low) / 2;
        int left = max(a, low, mid);
        int right = max(a, mid+1, high);
        return (a[left] >= a[right]) ? left : right; 
    }
    
    public static void main(String args[]) {
        int testData[][] = {
                {1, 1, 1, 1, 1, 1, 1},
                {10, 8, -4, 89, 2, 0, 4, -19, 200},
                {5, 4, 3, 2, 1, 1, 0, 0, -1},
                {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
                {1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8},
                {3, 2, 6, 13, 8, 4, 10, 7, 14, 11, 12, 5, 9},
                {65, 85, 17, 88, 66, 71, 45, 38, 95, 48, 18, 68, 60, 96, 55},
                {10, 8, 14, 89, 32, 50, 77, 38} 
            };
        
        for (int[] a : testData) {
            System.out.println("The original array: " + Arrays.toString(a));
            System.out.println("a peak: " + peak(a));
            System.out.println("The index of a maximum element is (recursive): " + max(a));
            
            int secondIndex = second(a);
            System.out.println("second largest: a[" + secondIndex + "] = " + a[secondIndex]);
            
            int[] mm = maxmin(a);
            System.out.println("max index = " + mm[0] + " (value=" + a[mm[0]] + 
                             "), min index = " + mm[1] + " (value=" + a[mm[1]] + ")");
            
            System.out.println("The number of inversions: " + inversion(a));
            System.out.println("\n");
        }
    }
}