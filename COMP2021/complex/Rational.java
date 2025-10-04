package hk.edu.polyu.comp.comp2021.assignment1.complex;

public class Rational {

    // Task 2: add the missing fields
    private int numerator;
    private int denominator;

    // Task 3: 	Complete the constructor and
    // the methods add, subtract, multiply, divide, simplify, and toString.

    public Rational(int numerator, int denominator){
        this.numerator = numerator;
        this.denominator = denominator;
    }

    public Rational add(Rational other){
        int resultn = (this.numerator * other.denominator) + (other.numerator * this.denominator);
        int resultd = this.denominator * other.denominator;
        return new Rational(resultn, resultd);
    }

    public Rational subtract(Rational other){
        int resultn = (this.numerator * other.denominator) - (other.numerator * this.denominator);
        int resultd = this.denominator * other.denominator;
        return new Rational(resultn, resultd);
    }

    public Rational multiply(Rational other){
        int resultn = (this.numerator * other.numerator);
        int resultd = this.denominator * other.denominator;
        return new Rational(resultn, resultd);
    }

    public Rational divide(Rational other){
        int resultn = (this.numerator * other.denominator);
        int resultd = this.denominator * other.numerator;
        return new Rational(resultn, resultd);
    }

    public String toString(){
       return (Integer.toString(this.numerator) +'/' + Integer.toString(this.denominator));
    }

    public void simplify(){
        int gcd =  gcd(this.numerator, this.denominator);
    
        this.numerator = this.numerator  / gcd;
        this.denominator =  this.denominator / gcd;
    }

    // ========================================== Do not change the methods below.

    private int getNumerator() {
        return numerator;
    }

    private void setNumerator(int numerator) {
        this.numerator = numerator;
    }

    private int getDenominator() {
        return denominator;
    }

    private void setDenominator(int denominator) {
        this.denominator = denominator;
    }

    private int gcd(int a, int b){
        if(b == 0)
            return a;
        else
            return gcd(b, a % b);
    }

}
