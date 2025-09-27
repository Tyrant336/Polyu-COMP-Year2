package hk.edu.polyu.comp.comp2021.assignment1.complex;

public class Complex {

    // Task 4: add the missing fields



    // Task 5: Complete the constructor as well as the methods add, subtract, multiply, divide, and toString.
    public Complex(Rational real, Rational imag) {
        // Todo: complete the constructor


    }


    public Complex add(Complex other) {
        // Todo: complete the method


    }

    public Complex subtract(Complex other) {
        // Todo: complete the method



    }

    public Complex multiply(Complex other) {
        // Todo: complete the method


    }

    public Complex divide(Complex other) {
        // Todo: complete the method
        // you may assume 'other' is never equal to '0+/-0i'.



    }

    public void simplify() {
        // Todo: complete the method



    }

    public String toString() {
        // Todo: complete the method



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
