package coursework.basics;

import coursework.util.Console;

/**
 * Three small loop exercises: repeating a character, computing a power of two,
 * and primality testing.
 */
public final class LoopMath1 {

    private LoopMath1() {
    }

    /** Returns a string of {@code length} lowercase x characters. */
    public static String makeXString(int length) {
        if (length < 0) {
            throw new IllegalArgumentException("length must not be negative");
        }
        return "x".repeat(length);
    }

    /**
     * Returns {@code 2^exponent} as a {@code long}.
     *
     * @throws ArithmeticException if the result would overflow a long
     */
    public static long powerOfTwo(int exponent) {
        if (exponent < 0) {
            throw new IllegalArgumentException("exponent must not be negative");
        }
        if (exponent > 62) {
            throw new ArithmeticException("2^" + exponent + " does not fit in a long");
        }
        return 1L << exponent;
    }

    /** Returns {@code true} when {@code number} is prime. */
    public static boolean isPrime(int number) {
        if (number < 2) {
            return false;
        }
        if (number == 2) {
            return true;
        }
        if (number % 2 == 0) {
            return false;
        }
        for (int divisor = 3; (long) divisor * divisor <= number; divisor += 2) {
            if (number % divisor == 0) {
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            int number = console.readNonNegativeInt("Please input a non-negative integer: ");
            System.out.println("Here are your x's: " + makeXString(number));
            if (number > 62) {
                System.out.println("2^" + number + " is too large for a 64-bit integer.");
            } else {
                System.out.printf("2^%d = %d%n", number, powerOfTwo(number));
            }
            if (number < 2) {
                System.out.println(number + " is neither prime nor composite.");
            } else {
                System.out.println(number + (isPrime(number) ? " is prime." : " is composite."));
            }
        }
    }
}
