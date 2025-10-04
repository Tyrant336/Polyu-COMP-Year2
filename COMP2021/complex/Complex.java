package hk.edu.polyu.comp.comp2021.assignment1.complex;


public class Complex {

    // Task 4: add the missing fields
    private Rational real;
    private Rational imag;


    // Task 5: Complete the constructor as well as the methods add, subtract, multiply, divide, and toString.
    public Complex(Rational real, Rational imag) {
        this.real = real;
        this.imag = imag;
    }


    public Complex add(Complex other) {
        Rational r = this.real.add(other.real);
        Rational i = this.imag.add(other.imag);
        return new Complex(r,i);
    }

    public Complex subtract(Complex other) {
        Rational r = this.real.subtract(other.real);
        Rational i = this.imag.subtract(other.imag);
        return new Complex(r, i);
    }

    public Complex multiply(Complex other) {
        Rational r = this.real.multiply(other.real);
        Rational i = this.imag.multiply(other.imag);
        return new Complex(r, i);


    }

    public Complex divide(Complex other) {
        Rational r = this.real.divide(other.real);
        Rational i = this.imag.divide(other.imag);
        return new Complex(r, i);
    }

    public void simplify() {
        this.real.simplify();
        this.imag.simplify();
    }

    public String toString() {
        return "(" + this.real.toString() + "/" +this.imag.toString() + ")";
    }

    // =========================== Do not change the methods below


    private Rational getReal() {
        return real;
    }

    private void setReal(Rational real) {
        this.real = real;
    }

    private Rational getImag() {
        return imag;
    }

    private void setImag(Rational imag) {
        this.imag = imag;
    }
}
