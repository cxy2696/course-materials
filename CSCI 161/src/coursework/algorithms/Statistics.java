package coursework.algorithms;

import java.util.Objects;

/** Descriptive statistics; standard deviation uses the population formula. */
public final class Statistics {

    private Statistics() {
    }

    /** Returns the arithmetic mean. */
    public static double average(double[] values) {
        validate(values);
        double sum = 0.0;
        for (double value : values) {
            sum += value;
        }
        return sum / values.length;
    }

    /** Returns the population variance. */
    public static double variance(double[] values) {
        validate(values);
        double mean = average(values);
        double sum = 0.0;
        for (double value : values) {
            double difference = value - mean;
            sum += difference * difference;
        }
        return sum / values.length;
    }

    /** Returns the population standard deviation. */
    public static double standardDeviation(double[] values) {
        return Math.sqrt(variance(values));
    }

    /** Returns the largest value. */
    public static double max(double[] values) {
        validate(values);
        double maximum = values[0];
        for (double value : values) {
            maximum = Math.max(maximum, value);
        }
        return maximum;
    }

    /** Returns the smallest value. */
    public static double min(double[] values) {
        validate(values);
        double minimum = values[0];
        for (double value : values) {
            minimum = Math.min(minimum, value);
        }
        return minimum;
    }

    /** Returns the zero-based index of the first occurrence of the maximum. */
    public static int indexOfMax(double[] values) {
        validate(values);
        int index = 0;
        for (int current = 1; current < values.length; current++) {
            if (values[current] > values[index]) {
                index = current;
            }
        }
        return index;
    }

    /** Returns the zero-based index of the first occurrence of the minimum. */
    public static int indexOfMin(double[] values) {
        validate(values);
        int index = 0;
        for (int current = 1; current < values.length; current++) {
            if (values[current] < values[index]) {
                index = current;
            }
        }
        return index;
    }

    private static void validate(double[] values) {
        Objects.requireNonNull(values, "values");
        if (values.length == 0) {
            throw new IllegalArgumentException("at least one value is required");
        }
    }
}
