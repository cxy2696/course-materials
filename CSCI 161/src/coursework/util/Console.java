package coursework.util;

import java.util.Scanner;

/** Console input with validation; use in a try-with-resources block. */
public final class Console implements AutoCloseable {

    private final Scanner scanner;

    public Console() {
        this.scanner = new Scanner(System.in);
    }

    /**
     * Prints {@code prompt} and reads one line.
     *
     * @return the trimmed line (possibly empty)
     */
    public String readLine(String prompt) {
        System.out.print(prompt);
        return scanner.nextLine().trim();
    }

    /**
     * Reads a line, re-prompting until it is not blank.
     */
    public String readNonBlank(String prompt) {
        while (true) {
            String value = readLine(prompt);
            if (!value.isEmpty()) {
                return value;
            }
            System.out.println("Please enter a non-empty value.");
        }
    }

    /**
     * Reads a whole number, re-prompting on malformed input.
     */
    public int readInt(String prompt) {
        while (true) {
            String value = readLine(prompt);
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException exception) {
                System.out.println("'" + value + "' is not a whole number. Please try again.");
            }
        }
    }

    /**
     * Reads a whole number within {@code [min, max]}, inclusive.
     */
    public int readInt(String prompt, int min, int max) {
        if (min > max) {
            throw new IllegalArgumentException("min must not be greater than max");
        }
        while (true) {
            int value = readInt(prompt);
            if (value >= min && value <= max) {
                return value;
            }
            System.out.printf("Please enter a number between %d and %d.%n", min, max);
        }
    }

    /**
     * Reads a positive whole number ({@code >= 1}).
     */
    public int readPositiveInt(String prompt) {
        while (true) {
            int value = readInt(prompt);
            if (value > 0) {
                return value;
            }
            System.out.println("Please enter a positive whole number.");
        }
    }

    /**
     * Reads a non-negative whole number ({@code >= 0}).
     */
    public int readNonNegativeInt(String prompt) {
        while (true) {
            int value = readInt(prompt);
            if (value >= 0) {
                return value;
            }
            System.out.println("Please enter a whole number greater than or equal to zero.");
        }
    }

    /**
     * Reads a decimal number, re-prompting on malformed input.
     */
    public double readDouble(String prompt) {
        while (true) {
            String value = readLine(prompt);
            try {
                return Double.parseDouble(value);
            } catch (NumberFormatException exception) {
                System.out.println("'" + value + "' is not a number. Please try again.");
            }
        }
    }

    /**
     * Asks a yes/no question and accepts y, yes, n, or no (case-insensitive).
     */
    public boolean readYesNo(String prompt) {
        while (true) {
            String value = readLine(prompt).toLowerCase();
            if (value.equals("y") || value.equals("yes")) {
                return true;
            }
            if (value.equals("n") || value.equals("no")) {
                return false;
            }
            System.out.println("Please answer yes or no.");
        }
    }

    @Override
    public void close() {
        scanner.close();
    }
}
