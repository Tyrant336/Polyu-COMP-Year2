public class Hero {
    String name = "";
    int health = 1;
    {
        health = 100;
    }
    Hero(String name, int health)
    {
        this.name = name;
        this.health = health;
    }
    int gold = health +1;
    {gold = 5;}
    public static void main(String[] args) {
        System.out.println("hello");
    }
}
