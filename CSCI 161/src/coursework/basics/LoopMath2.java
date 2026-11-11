package coursework.basics;

import coursework.util.Console;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

/**
 * Loop exercises: odd numbers, factorials, and Fibonacci numbers.
 */
public final class LoopMath2 {

    private LoopMath2() {
    }

    /** Returns the positive odd numbers less than or equal to {@code limit}. */
    public static List<Integer> oddNumbersUpTo(int limit) {
        if (limit < 0) {
            throw new IllegalArgumentException("limit must not be negative");
        }
        return IntStream.iterate(1, value -> value + 2)
                .limit((limit + 1L) / 2)
                .boxed()
                .collect(Collectors.toUnmodifiableList());
    }

    /**
     * Returns {@code n!}.
     *
     * @throws ArithmeticException if the result does not fit in a long
     */
    public static long factorial(int n) {
        if (n < 0) {
            throw new IllegalArgumentException("n must not be negative");
        }
        if (n > 20) {
            throw new ArithmeticException(n + "! does not fit in a long");
        }
        long result = 1;
        for (int factor = 2; factor <= n; factor++) {
            result *= factor;
        }
        return result;
    }

    /**
     * Returns the {@code n}-th Fibonacci number, with {@code F(0) = 0} and
     * {@code F(1) = 1}.
     */
    public static long fibonacci(int n) {
        if (n < 0) {
            throw new IllegalArgumentException("n must not be negative");
        }
        if (n > 92) {
            throw new ArithmeticException("F(" + n + ") does not fit in a long");
        }
        long previous = 0;
        long current = 1;
        for (int index = 0; index < n; index++) {
            long next = previous + current;
            previous = current;
            current = next;
        }
        return previous;
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            int number = console.readNonNegativeInt("Please enter a non-negative integer: ");
            List<Integer> oddNumbers = oddNumbersUpTo(number);
            if (oddNumbers.isEmpty()) {
                System.out.println("There are no positive odd numbers less than or equal to 0.");
            } else {
                String values = oddNumbers.stream()
                        .map(String::valueOf)
                        .collect(Collectors.joining(", "));
                System.out.printf("Positive odd numbers less than or equal to %d: %s%n", number, values);
            }
            if (number > 20) {
                System.out.println(number + "! is too large for a 64-bit integer.");
            } else {
                System.out.printf("%d! = %d%n", number, factorial(number));
            }
            if (number > 92) {
                System.out.println("Fib(" + number + ") is too large for a 64-bit integer.");
            } else {
                System.out.printf("Fib(%d) = %d%n", number, fibonacci(number));
            }
        }
    }
}
