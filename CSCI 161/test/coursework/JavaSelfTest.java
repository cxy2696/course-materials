package coursework;

import coursework.algorithms.Partners;
import coursework.algorithms.RabbitsAndFoxes;
import coursework.algorithms.SieveOfEratosthenes;
import coursework.algorithms.Sorting;
import coursework.algorithms.Statistics;
import coursework.basics.LoopMath1;
import coursework.basics.LoopMath2;
import coursework.cards.Card;
import coursework.cards.CardSet;
import coursework.oop.Fraction;
import coursework.oop.Vector;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

/**
 * Dependency-free regression tests for the reusable Java classes.
 *
 * <p>Run after compiling both trees:</p>
 * <pre>{@code
 * javac -cp java/out -d java/out-test java/test/coursework/JavaSelfTest.java
 * java -cp java/out:java/out-test coursework.JavaSelfTest
 * }</pre>
 */
public final class JavaSelfTest {

    private static int checks;

    private JavaSelfTest() {
    }

    public static void main(String[] args) {
        testSorting();
        testStatistics();
        testSieve();
        testLoopMath();
        testPartners();
        testRabbitsAndFoxes();
        testFraction();
        testVector();
        testCard();
        testCardSet();
        System.out.printf("All %d Java checks passed.%n", checks);
    }

    private static void testSorting() {
        int[][] inputs = {
                {},
                {1},
                {2, 1},
                {5, 1, 4, 2, 3},
                {3, 3, 1, 2, 1},
                {9, 8, 7, 6, 5, 4, 3, 2, 1}
        };
        for (int[] input : inputs) {
            int[] expected = input.clone();
            Arrays.sort(expected);

            int[] bubble = input.clone();
            Sorting.bubbleSort(bubble);
            check(Arrays.equals(expected, bubble), "bubble sort " + Arrays.toString(input));

            int[] selection = input.clone();
            Sorting.selectionSort(selection);
            check(Arrays.equals(expected, selection), "selection sort " + Arrays.toString(input));

            int[] shaker = input.clone();
            Sorting.shakerSort(shaker);
            check(Arrays.equals(expected, shaker), "shaker sort " + Arrays.toString(input));
        }

        int[] generated = Sorting.randomArray(100, 101, new Random(7));
        check(generated.length == 100, "randomArray length");
        check(Arrays.stream(generated).allMatch(value -> value >= 1 && value <= 100),
                "randomArray bounds");
        expectThrows(IllegalArgumentException.class,
                () -> Sorting.randomArray(-1, 10, new Random()), "negative randomArray size");
    }

    private static void testStatistics() {
        double[] values = {2.0, 3.0, 7.0};
        check(close(Statistics.average(values), 4.0), "average");
        check(close(Statistics.variance(values), 14.0 / 3.0), "variance");
        check(close(Statistics.standardDeviation(values), Math.sqrt(14.0 / 3.0)),
                "standard deviation");
        check(close(Statistics.max(values), 7.0), "max");
        check(close(Statistics.min(values), 2.0), "min");
        check(Statistics.indexOfMax(values) == 2, "indexOfMax");
        check(Statistics.indexOfMin(values) == 0, "indexOfMin");
        expectThrows(IllegalArgumentException.class,
                () -> Statistics.average(new double[0]), "empty statistics");
    }

    private static void testSieve() {
        check(Arrays.equals(
                        new int[] {2, 3, 5, 7, 11, 13, 17, 19, 23, 29},
                        SieveOfEratosthenes.primesUpTo(30)),
                "sieve up to 30");
        check(SieveOfEratosthenes.primesUpTo(1).length == 0, "sieve up to 1");
        check(SieveOfEratosthenes.sieve(0).length == 1, "sieve of zero");
        expectThrows(IllegalArgumentException.class,
                () -> SieveOfEratosthenes.sieve(-1), "negative sieve");
    }

    private static void testLoopMath() {
        check("xxx".equals(LoopMath1.makeXString(3)), "makeXString");
        check(LoopMath1.makeXString(0).isEmpty(), "makeXString empty");
        check(LoopMath1.powerOfTwo(10) == 1024L, "powerOfTwo");
        check(LoopMath1.isPrime(2), "2 is prime");
        check(LoopMath1.isPrime(97), "97 is prime");
        check(!LoopMath1.isPrime(1), "1 is not prime");
        check(!LoopMath1.isPrime(100), "100 is not prime");
        expectThrows(ArithmeticException.class,
                () -> LoopMath1.powerOfTwo(63), "powerOfTwo overflow");

        check(LoopMath2.oddNumbersUpTo(9).equals(List.of(1, 3, 5, 7, 9)), "oddNumbersUpTo");
        check(LoopMath2.oddNumbersUpTo(0).isEmpty(), "oddNumbersUpTo zero");
        check(LoopMath2.factorial(5) == 120L, "factorial");
        check(LoopMath2.factorial(0) == 1L, "factorial zero");
        check(LoopMath2.fibonacci(0) == 0L, "fibonacci zero");
        check(LoopMath2.fibonacci(10) == 55L, "fibonacci ten");
        expectThrows(ArithmeticException.class,
                () -> LoopMath2.factorial(21), "factorial overflow");
    }

    private static void testPartners() {
        check(Partners.pairings(new String[] {"B", "A", "C"})
                        .equals(List.of("A & B", "A & C", "B & C")),
                "pairings");
        check(Partners.pairings(new String[0]).isEmpty(), "empty pairings");
    }

    private static void testRabbitsAndFoxes() {
        int[][] populations = RabbitsAndFoxes.simulate(3, 10, 5);
        check(populations.length == 2, "rabbit/fox rows");
        check(populations[0].length == 4, "rabbit/fox years");
        check(populations[0][0] == 10 && populations[1][0] == 5, "initial populations");
        check(Arrays.stream(populations[0]).allMatch(value -> value >= 0), "rabbits non-negative");
        check(Arrays.stream(populations[1]).allMatch(value -> value >= 0), "foxes non-negative");
        expectThrows(IllegalArgumentException.class,
                () -> RabbitsAndFoxes.simulate(-1, 1, 1), "negative years");
    }

    private static void testFraction() {
        Fraction half = new Fraction(1, 2);
        Fraction third = new Fraction(1, 3);
        check(new Fraction(2, 4).equals(half), "fraction reduction");
        check(new Fraction(2, -4).equals(new Fraction(-1, 2)), "negative denominator");
        check(half.add(third).equals(new Fraction(5, 6)), "fraction add");
        check(half.subtract(third).equals(new Fraction(1, 6)), "fraction subtract");
        check(half.multiply(third).equals(new Fraction(1, 6)), "fraction multiply");
        check(half.divide(third).equals(new Fraction(3, 2)), "fraction divide");
        check(half.compareTo(third) > 0, "fraction compare");
        check(half.hashCode() == new Fraction(1, 2).hashCode(), "fraction hashCode");
        check("1/2".equals(half.toString()), "fraction toString");
        check("3".equals(new Fraction(6, 2).toString()), "whole fraction toString");
        check(close(half.toDouble(), 0.5), "fraction toDouble");

        expectThrows(ArithmeticException.class,
                () -> new Fraction(1, 0), "zero denominator");
        expectThrows(ArithmeticException.class,
                () -> half.divide(new Fraction(0, 1)), "divide by zero fraction");
    }

    private static void testVector() {
        Vector first = new Vector(1, 2, 3);
        Vector second = new Vector(4, 5, 6);
        check(first.add(second).equals(new Vector(5, 7, 9)), "vector add");
        check(first.subtract(second).equals(new Vector(-3, -3, -3)), "vector subtract");
        check(first.multiply(2).equals(new Vector(2, 4, 6)), "vector multiply");
        check(close(first.dot(second), 32.0), "vector dot");
        check(first.cross(second).equals(new Vector(-3, 6, -3)), "vector cross");
        check(close(first.length(), Math.sqrt(14.0)), "vector length");
        check(close(first.normalized().length(), 1.0), "vector normalize");
        check(close(first.angleBetween(second), 0.2257261285527342), "vector angle");
        check(first.equals(new Vector(1, 2, 3)), "vector equals");
        check(first.hashCode() == new Vector(1, 2, 3).hashCode(), "vector hashCode");
        expectThrows(ArithmeticException.class,
                () -> new Vector(0, 0, 0).normalized(), "normalize zero vector");
        expectThrows(ArithmeticException.class,
                () -> new Vector(0, 0, 0).angleBetween(first), "angle with zero vector");
    }

    private static void testCard() {
        Card ace = new Card(Card.ACE, Card.SPADES);
        Card king = new Card(Card.KING, Card.HEARTS);
        check(ace.compareTo(king) < 0, "card compare");
        check(king.isFaceCard(), "face card");
        check(king.isRed(), "red card");
        check(ace.isBlack(), "black card");
        check(ace.hasSameSuit(new Card(7, Card.SPADES)), "same suit");
        check(ace.hasSameRank(new Card(Card.ACE, Card.HEARTS)), "same rank");
        check("Ace of Spades".equals(ace.toString()), "card toString");
        check(ace.equals(new Card(Card.ACE, Card.SPADES)), "card equals");
        check(ace.hashCode() == new Card(Card.ACE, Card.SPADES).hashCode(), "card hashCode");
        check(!ace.equals(new Card(Card.ACE, Card.HEARTS)), "different suit");
        expectThrows(IllegalArgumentException.class,
                () -> new Card(0, 0), "invalid card rank");
        expectThrows(IllegalArgumentException.class,
                () -> new Card(1, 4), "invalid card suit");
        for (int index = 0; index < 100; index++) {
            Card random = new Card();
            check(random.getRank() >= Card.ACE && random.getRank() <= Card.KING,
                    "random card rank");
            check(random.getSuit() >= Card.CLUBS && random.getSuit() <= Card.HEARTS,
                    "random card suit");
        }
    }

    private static void testCardSet() {
        CardSet deck = CardSet.makeStandardDeck();
        check(deck.getSize() == 52, "standard deck size");
        Set<Card> unique = new HashSet<>(deck.asList());
        check(unique.size() == 52, "standard deck unique");

        CardSet shuffled = CardSet.makeStandardDeck();
        shuffled.shuffle(new Random(42));
        check(shuffled.getSize() == 52, "shuffled deck size");
        check(new HashSet<>(shuffled.asList()).equals(unique), "shuffle preserves cards");

        Card removed = deck.discard(0);
        check(removed.equals(new Card(Card.ACE, Card.CLUBS)), "discard first card");
        check(deck.getSize() == 51, "deck size after discard");
        expectThrows(IndexOutOfBoundsException.class,
                () -> deck.discard(99), "discard invalid index");
        expectThrows(UnsupportedOperationException.class,
                () -> deck.asList().add(new Card()), "unmodifiable deck view");
    }

    private static void check(boolean condition, String description) {
        checks++;
        if (!condition) {
            throw new AssertionError("check failed: " + description);
        }
    }

    private static void expectThrows(
            Class<? extends Throwable> expected, Runnable action, String description) {
        checks++;
        try {
            action.run();
        } catch (Throwable thrown) {
            if (expected.isInstance(thrown)) {
                return;
            }
            throw new AssertionError(
                    "check failed: " + description + " threw " + thrown.getClass().getName(), thrown);
        }
        throw new AssertionError("check failed: " + description + " did not throw");
    }

    private static boolean close(double first, double second) {
        return Math.abs(first - second) < 1.0e-9;
    }
}
