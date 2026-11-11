package coursework.basics;

import coursework.util.Console;

/**
 * String operations: length, concatenation, case-insensitive equality,
 * searching, upper-casing, and parsing.
 */
public final class StringManipulation {

    private StringManipulation() {
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            String first = console.readNonBlank("Please enter String 1: ");
            String second = console.readNonBlank("Please enter String 2: ");
            String third = console.readNonBlank("Please enter String 3: ");

            System.out.println("Length of String 2: " + second.length());
            System.out.println("String 1 + String 2: " + first + " " + second);
            System.out.println("String 1 equals String 2 (ignoring case): "
                    + first.equalsIgnoreCase(second));
            System.out.println("First index of 'c' in String 1: " + first.indexOf('c'));
            System.out.println("String 3 inside String 2 starts at: " + second.indexOf(third));
            System.out.println("String 2 in upper case: " + second.toUpperCase());

            try {
                int number = Integer.parseInt(third);
                System.out.println(third + " + 10 = " + (number + 10));
            } catch (NumberFormatException exception) {
                System.out.println("'" + third + "' is not an integer, so the +10 step is skipped.");
            }
        }
    }
}
