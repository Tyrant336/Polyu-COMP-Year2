import java.security.SecureRandom;
import java.util.Scanner;

/**
 * 
 * @author Yixin Cao (August 26, 2022)
 *
 * Try to find the secret number by guessing.
 * If your guess is too high or too low, you'll get a hint.
 */
public class Bingo {
    public static void main(String[] args) {
        System.out.printf("Try to find the secret number by guessing.\n"
        		+ "If your guess is too high or too low, you'll get a hint.\n"
        		+ "You may quit by inputting -1.\n"
        		);
        SecureRandom random = new SecureRandom();
        int secret = random.nextInt(1<<16);
        int count = 1;
        
        Scanner scanner = new Scanner(System.in);  
        while (true) { 
        	int guess = scanner.nextInt();
        	if (-1 == guess) return;   
        	if (secret == guess) {        	
        		System.out.println("Bingo! " + count + " guesses.");
        		return;
        	}
        	System.out.println("Your guess is too " + ((secret > guess)?"small":"large") + ".\nNext guess: ");
        	count++;
        }
    }
}