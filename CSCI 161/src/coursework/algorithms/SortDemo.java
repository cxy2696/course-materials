package coursework.algorithms;

import coursework.util.Console;
import java.util.Arrays;
import java.util.Random;
import java.util.function.Consumer;

/** Shared interactive driver for the three sorting labs. */
final class SortDemo {

    private static final int PRINT_LIMIT = 100;

    private SortDemo() {
    }

    static void run(String algorithmName, Consumer<int[]> algorithm) {
        try (Console console = new Console()) {
            int size = console.readPositiveInt("Please enter the array size: ");
            int[] values = Sorting.randomArray(size, size + 1, new Random());
            if (size <= PRINT_LIMIT) {
                System.out.println("Unsorted: " + Arrays.toString(values));
            }

            long start = System.nanoTime();
            algorithm.accept(values);
            long elapsedNanos = System.nanoTime() - start;

            if (size <= PRINT_LIMIT) {
                System.out.println("Sorted:   " + Arrays.toString(values));
            }
            if (!isSorted(values)) {
                throw new IllegalStateException(algorithmName + " produced an unsorted array");
            }
            System.out.printf("%s sorted %d values in %.3f ms.%n",
                    algorithmName, size, elapsedNanos / 1_000_000.0);
        }
    }

    private static boolean isSorted(int[] values) {
        for (int index = 1; index < values.length; index++) {
            if (values[index - 1] > values[index]) {
                return false;
            }
        }
        return true;
    }
}
