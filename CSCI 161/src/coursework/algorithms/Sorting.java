package coursework.algorithms;

import java.util.Objects;
import java.util.Random;

/** In-place integer sorting algorithms used by the sorting labs. */
public final class Sorting {

    private Sorting() {
    }

    /** Sorts {@code values} in ascending order with bubble sort. */
    public static void bubbleSort(int[] values) {
        Objects.requireNonNull(values, "values");
        for (int end = values.length - 1; end > 0; end--) {
            boolean swapped = false;
            for (int index = 0; index < end; index++) {
                if (values[index] > values[index + 1]) {
                    swap(values, index, index + 1);
                    swapped = true;
                }
            }
            if (!swapped) {
                return;
            }
        }
    }

    /** Sorts {@code values} in ascending order with selection sort. */
    public static void selectionSort(int[] values) {
        Objects.requireNonNull(values, "values");
        for (int start = 0; start < values.length - 1; start++) {
            int minimum = start;
            for (int index = start + 1; index < values.length; index++) {
                if (values[index] < values[minimum]) {
                    minimum = index;
                }
            }
            if (minimum != start) {
                swap(values, start, minimum);
            }
        }
    }

    /** Sorts {@code values} in ascending order with cocktail/shaker sort. */
    public static void shakerSort(int[] values) {
        Objects.requireNonNull(values, "values");
        int left = 0;
        int right = values.length - 1;
        while (left < right) {
            int lastSwap = left;
            for (int index = left; index < right; index++) {
                if (values[index] > values[index + 1]) {
                    swap(values, index, index + 1);
                    lastSwap = index;
                }
            }
            right = lastSwap;

            lastSwap = right;
            for (int index = right; index > left; index--) {
                if (values[index - 1] > values[index]) {
                    swap(values, index - 1, index);
                    lastSwap = index - 1;
                }
            }
            left = lastSwap;
        }
    }

    /**
     * Creates an array of {@code size} random values in {@code [1, maxExclusive)}.
     */
    public static int[] randomArray(int size, int maxExclusive, Random random) {
        if (size < 0) {
            throw new IllegalArgumentException("size must not be negative");
        }
        if (maxExclusive <= 1) {
            throw new IllegalArgumentException("maxExclusive must be greater than 1");
        }
        Objects.requireNonNull(random, "random");
        int[] values = new int[size];
        for (int index = 0; index < size; index++) {
            values[index] = random.nextInt(1, maxExclusive);
        }
        return values;
    }

    private static void swap(int[] values, int first, int second) {
        int temporary = values[first];
        values[first] = values[second];
        values[second] = temporary;
    }
}
