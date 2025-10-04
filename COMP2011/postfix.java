import java.util.Stack;

public class postfix {
    public static int calculation(String s)
    {
        Stack<Integer> stack = new Stack<>();
        for (char i: s)
        {
            if(i >= '0' && i <= '9')
            {
                stack.push((int)(i - '0'));
            }
        }
        return 0;
    }
}
