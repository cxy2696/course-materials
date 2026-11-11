package coursework.algorithms;

import coursework.util.Console;
import java.util.Arrays;

/**
 * The Sieve of Eratosthenes, separated into a reusable function and a small
 * interactive demo.
 */
public final class SieveOfEratosthenes {

    private SieveOfEratosthenes() {
    }

    /**
     * Returns a boolean array where {@code result[n]} is {@code true} exactly
     * when {@code n} is prime.
     *
     * @param maximum largest number to test; must be non-negative
     */
    public static boolean[] sieve(int maximum) {
        if (maximum < 0) {
            throw new IllegalArgumentException("maximum must not be negative");
        }
        boolean[] isPrime = new boolean[maximum + 1];
        Arrays.fill(isPrime, true);
        if (maximum >= 0) {
            isPrime[0] = false;
        }
        if (maximum >= 1) {
            isPrime[1] = false;
        }
        for (int candidate = 2; (long) candidate * candidate <= maximum; candidate++) {
            if (!isPrime[candidate]) {
                continue;
            }
            for (int multiple = candidate * candidate; multiple <= maximum; multiple += candidate) {
                isPrime[multiple] = false;
            }
        }
        return isPrime;
    }

    /** Returns all primes in {@code [2, maximum]}. */
    public static int[] primesUpTo(int maximum) {
        boolean[] isPrime = sieve(maximum);
        int count = 0;
        for (boolean prime : isPrime) {
            if (prime) {
                count++;
            }
        }
        int[] primes = new int[count];
        int index = 0;
        for (int value = 2; value < isPrime.length; value++) {
            if (isPrime[value]) {
                primes[index++] = value;
            }
        }
        return primes;
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            int maximum = console.readPositiveInt("Please enter a maximum number: ");
            int[] primes = primesUpTo(maximum);
            if (primes.length == 0) {
                System.out.println("There are no prime numbers between 2 and " + maximum + ".");
                return;
            }
            System.out.printf("There are %d primes between 2 and %d:%n", primes.length, maximum);
            System.out.println(Arrays.toString(primes));
        }
    }
}
