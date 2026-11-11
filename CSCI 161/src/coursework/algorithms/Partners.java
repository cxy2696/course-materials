package coursework.algorithms;

import coursework.util.Console;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

/**
 * Builds every unordered pair from a list of names.
 *
 * <p>The number of pairs is {@code n * (n - 1) / 2}; names are sorted first so
 * the output is stable regardless of input order.</p>
 */
public final class Partners {

    private Partners() {
    }

    /** Returns all unordered pairs, formatted as {@code "A & B"}. */
    public static List<String> pairings(String[] names) {
        Objects.requireNonNull(names, "names");
        String[] sorted = names.clone();
        for (String name : sorted) {
            if (name == null || name.isBlank()) {
                throw new IllegalArgumentException("names must not be blank");
            }
        }
        Arrays.sort(sorted);
        List<String> pairs = new ArrayList<>(sorted.length * (sorted.length - 1) / 2);
        for (int first = 0; first < sorted.length; first++) {
            for (int second = first + 1; second < sorted.length; second++) {
                pairs.add(sorted[first] + " & " + sorted[second]);
            }
        }
        return List.copyOf(pairs);
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            int count = console.readNonNegativeInt("How many people are there? ");
            String[] names = new String[count];
            if (count > 0) {
                System.out.println("Please enter the names of those people:");
                for (int index = 0; index < count; index++) {
                    names[index] = console.readNonBlank("  Name " + (index + 1) + ": ");
                }
            }
            List<String> pairs = pairings(names);
            System.out.printf("There are %d possible pairings.%n", pairs.size());
            pairs.forEach(System.out::println);
        }
    }
}
