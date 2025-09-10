package comp2011.lec1;

import java.util.*;

/**
 * 
 * @author Yixin Cao (August 31, 2024)
 *
 * Enumerate all subsets and permutations of a given set, withou duplications.
 * 
 * Subsets: [1,2,3] → {},{1},{2},{1,2},{3},{1,3},{2,3},{1,2,3}
 * 
 * Permutations: [1,2,3] → {1,2,3},{1,3,2},{2,1,3},{2,3,1},{3,2,1},{3,1,2}
 */
public class Enumerate {
    /*
     * Approach 1: Use a bit string of length n, each for a distinct element.
     *
     * 000000: { }
     * 000001: {A}
     * 000010: {B}
     * 000011: {A, B}
     * 000100: {C}
     * ....
     * 111111: {A, B, C, D, E, F}
     *
     * This elementary implementation can only handle a set of at most 31 elements.  Why?
     */
    public static List<List<Character>> generateSubsets(char[] set) {
        int n = set.length;
        List<List<Character>> ans = new ArrayList<List<Character>>();
        for (int i = 0; i < (1 << n); i++) {
            List<Character> li = new ArrayList<Character>();
            for (int j = 0; j < n; j++)
                if ((i & (1 << j)) > 0)
                    li.add(set[j]);
            ans.add(li);
        }
        return ans;
    }

    /*
     * The same approach as <code>generateSubsets</code>.
     * Here the subsets are printed.  
     */
    static void printSubsets(char set[]) {
        int n = set.length;

        for (int i = 0; i < (1 << n); i++) {
            System.out.print(i + ": { ");

            for (int j = 0; j < n; j++)
                if ((i & (1 << j)) > 0)
                    System.out.print(set[j] + " ");

            System.out.println("}");  // the only print*ln* to terminate the line
        }
    }

    /*
     * Approach 2: Illustrated as follows. 
     *
     *                            { }
     *             { }==========================={A}
     *       { }========{B}               {A}============={A, B}
     *   { }==={C}   {B}===={B, C}    {A}===={A, C}   {A, B}===={A, B, C}
     *
     * reference: https://www.geeksforgeeks.org/backtracking-to-find-all-subsets/
     */
    private static void generateSubsets(char[] set,
                                       List<List<Character>> res,
                                       List<Character> subset,
                                       int from) {
        res.add(new ArrayList<>(subset));

        for (int i = from; i < set.length; i++) {
            subset.add(set[i]);
            
            // Recursively generate subsets with the ith element included
            generateSubsets(set, res, subset, i + 1);

            // Generate subsets with the ith element excluded (backtracking)
            subset.remove(subset.size() - 1);
        }
    }

    public static List<List<Character>> generateSubsetsRecursive(char[] set) {
        List<Character> subset = new ArrayList<>();
        List<List<Character>> res = new ArrayList<>();

        int index = 0;
        generateSubsets(set, res, subset, index);
        return res;
    }

    /*
     * Approach 3: the geek's implementation of approach 2. 
     *                            { }
     *             { }==========================={A}
     *       { }========{B}               {A}============={A, B}
     *   { }==={C}   {B}===={B, C}    {A}===={A, C}   {A, B}===={A, B, C}
     *
     * Reference: https://www.topcoder.com/thrive/articles/print-all-subset-for-set-backtracking-and-bitmasking-approach 
     */
    private static void generateSubsetsDoublyRecursive(char[] nums, int i, List<Character> curr, List<List<Character>> ans) {
        if (i == nums.length) {
            ans.add(new ArrayList<Character>(curr));
            return;
        }
        
        curr.add(nums[i]);
        generateSubsetsDoublyRecursive(nums, i + 1, curr, ans);
        curr.remove(curr.size() - 1);
        generateSubsetsDoublyRecursive(nums, i + 1, curr, ans);
    }
    public static List<List<Character>> generateSubsetsDoublyRecursive(char[] nums) {
        List<Character> curr = new ArrayList<Character>();
        List<List<Character>> ans = new ArrayList<List<Character>>();
        generateSubsetsDoublyRecursive(nums, 0, curr, ans);
        return ans;
    }


    /* 
     * To generate subsets in order: 
     * [1,2,3] → {},{1},{2},{3},{1,2},{1,3},{2,3},{1,2,3}
     * 
     * You may find the following web page helpful.
     * https://www.geeksforgeeks.org/print-subsets-given-size-set/
     */
    
    public static List<List<Character>> generateSubsetsInorder(char[] nums) {
    	return null;
    }
    
    /*
     * To generate all permutations
     */
    public static List<List<Character>> generatePermutations(char[] set) {
    	return null;	
    }
    
    public static void main(String[] s) {
        char set[] = new char[22];
        for (int i = 0; i < set.length; i++) {
            set[i] = (char) ('A' + i);
        }
        long startTime = 0;
        double duration = 0;
        startTime = System.currentTimeMillis();
        List<List<Character>> subsets = generateSubsets(set);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        System.out.println("Generating all " + subsets.size() + " subsets takes " + (duration) + " seconds.");
        // You can uncomment the following line to print out the results.
        // subsets.forEach(System.out::println);

        startTime = System.currentTimeMillis();
        subsets = generateSubsetsRecursive(set);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        System.out.println("Generating all " + subsets.size() + " subsets recursively takes " + (duration) + " seconds.");
        // subsets.forEach(System.out::println);

        startTime = System.currentTimeMillis();
        subsets = generateSubsetsDoublyRecursive(set);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        System.out.println("Generating all " + subsets.size() + " subsets doubly recursively takes " + (duration) + " seconds.");
        // subsets.forEach(System.out::println);

        /*
         // Guess the answer before you try it out.
        startTime = System.currentTimeMillis();
        printSubsets(set);
        duration = (System.currentTimeMillis() - startTime) / 1000.;
        System.out.println("Printing all subsets takes " + (duration) + " seconds.");
        */
    }
}
