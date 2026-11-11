package coursework.oop;

/**
 * A rational number stored in lowest terms with the sign in the numerator.
 */
public final class Fraction implements Comparable<Fraction> {

    private int numerator;
    private int denominator;

    /** Creates {@code numerator / denominator}. */
    public Fraction(int numerator, int denominator) {
        assign(numerator, denominator);
    }

    /** Creates a whole-number fraction. */
    public Fraction(int numerator) {
        this(numerator, 1);
    }

    /** Returns {@code this + other}. */
    public Fraction add(Fraction other) {
        requireNonNull(other);
        long resultNumerator = (long) numerator * other.denominator
                + (long) other.numerator * denominator;
        long resultDenominator = (long) denominator * other.denominator;
        return fromLongs(resultNumerator, resultDenominator);
    }

    /** Returns {@code this - other}. */
    public Fraction subtract(Fraction other) {
        requireNonNull(other);
        long resultNumerator = (long) numerator * other.denominator
                - (long) other.numerator * denominator;
        long resultDenominator = (long) denominator * other.denominator;
        return fromLongs(resultNumerator, resultDenominator);
    }

    /** Returns {@code this * other}. */
    public Fraction multiply(Fraction other) {
        requireNonNull(other);
        return fromLongs((long) numerator * other.numerator,
                (long) denominator * other.denominator);
    }

    /** Returns {@code this / other}. */
    public Fraction divide(Fraction other) {
        requireNonNull(other);
        if (other.numerator == 0) {
            throw new ArithmeticException("cannot divide by a zero fraction");
        }
        return fromLongs((long) numerator * other.denominator,
                (long) denominator * other.numerator);
    }

    /** Returns the closest {@code double} approximation. */
    public double toDouble() {
        return (double) numerator / denominator;
    }

    /** Returns the (signed) numerator. */
    public int getNumerator() {
        return numerator;
    }

    /** Returns the (always positive) denominator. */
    public int getDenominator() {
        return denominator;
    }

    /** Replaces the numerator and keeps the value normalized. */
    public void setNumerator(int newNumerator) {
        assign(newNumerator, denominator);
    }

    /** Replaces the denominator; zero is rejected. */
    public void setDenominator(int newDenominator) {
        assign(numerator, newDenominator);
    }

    @Override
    public int compareTo(Fraction other) {
        requireNonNull(other);
        return Long.compare((long) numerator * other.denominator,
                (long) other.numerator * denominator);
    }

    @Override
    public boolean equals(Object otherObject) {
        if (this == otherObject) {
            return true;
        }
        if (!(otherObject instanceof Fraction other)) {
            return false;
        }
        return numerator == other.numerator && denominator == other.denominator;
    }

    @Override
    public int hashCode() {
        return 31 * numerator + denominator;
    }

    @Override
    public String toString() {
        return denominator == 1 ? Integer.toString(numerator) : numerator + "/" + denominator;
    }

    private static Fraction fromLongs(long numerator, long denominator) {
        if (numerator < Integer.MIN_VALUE || numerator > Integer.MAX_VALUE
                || denominator < Integer.MIN_VALUE || denominator > Integer.MAX_VALUE) {
            throw new ArithmeticException("fraction result does not fit in an int");
        }
        return new Fraction((int) numerator, (int) denominator);
    }

    private void assign(long newNumerator, long newDenominator) {
        if (newDenominator == 0) {
            throw new ArithmeticException("denominator must not be zero");
        }
        if (newNumerator < Integer.MIN_VALUE || newNumerator > Integer.MAX_VALUE
                || newDenominator < Integer.MIN_VALUE || newDenominator > Integer.MAX_VALUE) {
            throw new ArithmeticException("fraction does not fit in an int");
        }
        long valueNumerator = newNumerator;
        long valueDenominator = newDenominator;
        if (valueDenominator < 0) {
            valueNumerator = -valueNumerator;
            valueDenominator = -valueDenominator;
        }
        long divisor = greatestCommonDivisor(Math.abs(valueNumerator), valueDenominator);
        numerator = (int) (valueNumerator / divisor);
        denominator = (int) (valueDenominator / divisor);
    }

    private static long greatestCommonDivisor(long first, long second) {
        while (second != 0) {
            long remainder = first % second;
            first = second;
            second = remainder;
        }
        return first == 0 ? 1 : first;
    }

    private static void requireNonNull(Fraction other) {
        if (other == null) {
            throw new IllegalArgumentException("other fraction must not be null");
        }
    }
}
