package coursework.basics;

import coursework.util.Console;

/**
 * A small four-function calculator that keeps whole-number division exact by
 * reporting a quotient and a remainder.
 */
public final class Calculator {

    private Calculator() {
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            System.out.println("Welcome to the calculator!");
            int first = console.readInt("Please enter your first integer: ");
            String operation = console.readNonBlank("Please choose an operation (+, -, *, /): ");

            switch (operation) {
                case "+" -> {
                    int second = console.readInt("Please enter another integer: ");
                    System.out.printf("%d + %d = %d%n", first, second, first + second);
                }
                case "-" -> {
                    int second = console.readInt("Please enter another integer: ");
                    System.out.printf("%d - %d = %d%n", first, second, first - second);
                }
                case "*" -> {
                    int second = console.readInt("Please enter another integer: ");
                    System.out.printf("%d * %d = %d%n", first, second, first * second);
                }
                case "/" -> divide(console, first);
                default -> System.out.println("Sorry, '" + operation + "' is not a valid operation.");
            }
        }
    }

    private static void divide(Console console, int dividend) {
        int divisor = console.readInt("Please enter another integer: ");
        if (divisor == 0) {
            System.out.println("Sorry, the denominator must not be zero.");
            return;
        }
        int quotient = dividend / divisor;
        int remainder = dividend % divisor;
        if (remainder == 0) {
            System.out.printf("%d / %d = %d%n", dividend, divisor, quotient);
        } else {
            System.out.printf("%d / %d = %d remainder %d%n", dividend, divisor, quotient, remainder);
        }
    }
}
