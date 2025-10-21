package comp2011.a1;
import java.util.HashMap;
import java.util.Map;

/**
 * Elementary tasks on arrays and running-time analysis.
 *
 * All submissions will be released on Blackboard, so please double check that you submission contains no identification information.
 *
 * Please do not modify the signatures of the methods.
 */

public class SimpleArray_333{ // Please replace 000 with your secret number!

    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.Neetcode
     *     2.
     *     3.
     *     ...
     *
     * Running time: Best cuse time is O(1), Worst case time si O(n).  
     */
 public static int q1(int a[]) {
        Map<Integer,Integer> dict = new HashMap<>();
        for(int i = 0; i < a.length; i++)
        {
            int val = a[i];
            if(dict.containsKey(val))
            {
                int freq = dict.get(val) + 1;
                if (freq >= 3)
                {
                    return i;
                }
                else
                {
                    dict.put(val,freq);
                }
            }
            else
            {
                dict.put(val,1);
            }
        }
        return -1;
    }


    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.Neetcode
     *     2.
     *     3.
     *     ...
     *
     * Running time: Worst time O(n) and best time is O(n), where n is length of the array.  
     */
    public static int q2(int a[]) {
        Map<Integer,Integer> dict = new HashMap<>();
        Map<Integer,Integer> ans = new HashMap<>();
        for(int i = 0; i < a.length; i++)
        {
            int val = a[i];
            if(dict.containsKey(val))
            {
                int freq = dict.get(val) + 1;
                if (freq == 3)
                {
                    ans.put(val,i);
                }
                else if (freq > 3 && ans.containsKey(val))
                {
                    ans.remove(val);
                }
                dict.put(val,freq);
                
            }
            else
            {
                dict.put(val,1);
            }
        }
        if (! ans.isEmpty())
        {
            int min = a.length;
            for (int i : ans.values())
            {
                if (i < min)
                {
                    min = i;
                }
            }
            return min;
        }
        return -1;
    }

    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.Neetcode
     *     2.
     *     3.
     *     ...
     *
     * Running time:Best time is O( 1  ), worst time is O(n).  
     */
    public static int q3(int[] a) {
        if (a == null || a.length < 3) return -1;
        
    // For real, if the first three element are the same, the best time should be O(1) by definition
        if (a[0] == a[1] && a[0] == a[2]) return 2;
        
        for (int i = 2; i < a.length; i++) 
        {
            if (a[i] == a[i - 2]) 
            {
                return i;
            }
        }
        return -1;
    }
    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.Neetcode
     *     2.
     *     3.
     *     ...
     *
     * Running time: BEst time is O(  1 ), worst is O(n).  
     */
public static int q4(int[] a) {
    if (a == null || a.length < 3) return -1;
    
    for (int i = 2; i < a.length; i++) 
    {
        if (a[i] == a[i - 2]) 
        {
            if (i == a.length - 1 || a[i] != a[i + 1]) 
            {
                return i;
            }
            while (i < a.length - 1 && a[i] == a[i + 1]) {
                i++;
            }
        }
    }
    return -1;
    }

    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1. Neetcode
     *     2.
     *     3.
     *     ...
     *
     * Running time: Best time is O( 1  ), Worst is O(logn).  
     */
    public static int q5(int[] a) {
        int l = 0, r = a.length - 1;
        while(l <= r)
        {
            int ans = (l + r) / 2;
            if (a[ans] - ans < 0)
            {
                l = ans + 1;
            }
            else if (a[ans] - ans > 0)
            {
                r = ans - 1;
            }
            else
            {
                return ans;
            }
        }
        return -1;
    }

    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1. deepseek
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * Running time: Best or Worst is still O( n ).  
     */
    public static int[] q6(int[] a1, int[] a2) {
        int n = a1.length;
        int[] ans = new int[n];
        int a = 0;
        int i = 0, j = 0;
       
        while (i < n && j < n)
        {
            if (a1[i] == a2[j])
            {
                ans[a++] = a1[i];
                i++;
                j++;
            }
            else if (a1[i] < a2[j])
            {
                i++;
            }
            else
            {
                j++;
            }
        }
        if(a1.length > 0)
        {
            return ans;
        }
        return null;
    }

    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * Running time: worst time is O( Math.pow(n,2) ), best time is O(1).  
     */
    public static int q7(int[] a) {
        java.util.Arrays.sort(a);
        int j = a.length;
        for(int k = 0; k < j; k++)
        {
            int l = k, r = j;
            while(l <= r)
            {
                if (a[k]== a[l] + a[r])
                {
                    return k;
                }
                else if (a[k] > a[l]+ a[r])
                {
                    l++;
                }
                else
                {
                    r--;
                }
            }
        }
        return -1;
    }

    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * Running time: O( nlogn  ).  
     */
    public static int q8(int[] a) {
        if (a.length == 0) return -1;
        java.util.Arrays.sort(a);
        int minDiff = a[1] - a[0];
        for (int i = 2; i < a.length; i++)
        {
            minDiff = Math.min(minDiff, Math.abs(a[i] - a[i - 1]));
        }
        return minDiff; // the correct answer must be nonnegative.
    }  

    /**
     * VERY IMPORTANT.
     *
     * I've sought help from the following GenAI:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've discussed this question with the following students (secret numbers, not names!):
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * I've sought help from the following Internet resources and books:
     *     1.
     *     2.
     *     3.
     *     ...
     *
     * Running time: O(   ).  
     */
    public static int q9(int[] a) {
        if (a.length == 0) return -1;
        java.util.Arrays.sort(a);
        int minDiff = a[1] - a[0];
        for (int i = 2; i < a.length; i++)
        {
            minDiff = Math.max(minDiff, Math.abs(a[i] - a[i - 1]));
        }
        return minDiff; // the correct answer must be nonnegative.
    }

    /*
     * You can use any Java library here for testing.
     * Please perform extensive testing.
     */
    public static void main(String[] args) {
    }
}


