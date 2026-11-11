package coursework.basics;

import coursework.util.Console;

/**
 * Menu-driven practice with conditionals: even/odd, quadrants, and quadratic
 * equations.
 */
public final class IfMath {

    private IfMath() {
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            System.out.println("1. Even/Odd Detector");
            System.out.println("2. Quadrant Finder");
            System.out.println("3. Quadratic Solver");
            int choice = console.readInt("Please choose an option (1-3): ", 1, 3);
            switch (choice) {
                case 1 -> evenOrOdd(console);
                case 2 -> quadrant(console);
                case 3 -> quadratic(console);
                default -> throw new IllegalStateException("unreachable");
            }
        }
    }

    private static void evenOrOdd(Console console) {
        int number = console.readInt("Please enter an integer: ");
        System.out.println(number + (number % 2 == 0 ? " is even." : " is odd."));
    }

    private static void quadrant(Console console) {
        double x = console.readDouble("Please enter the x coordinate: ");
        double y = console.readDouble("Please enter the y coordinate: ");
        String location;
        if (x == 0 && y == 0) {
            location = "the origin";
        } else if (x == 0) {
            location = "the y-axis";
        } else if (y == 0) {
            location = "the x-axis";
        } else if (x > 0 && y > 0) {
            location = "the first quadrant";
        } else if (x < 0 && y > 0) {
            location = "the second quadrant";
        } else if (x < 0 && y < 0) {
            location = "the third quadrant";
        } else {
            location = "the fourth quadrant";
        }
        System.out.println("The point (" + x + ", " + y + ") is in " + location + ".");
    }

    private static void quadratic(Console console) {
        double a = console.readDouble("Please enter a: ");
        double b = console.readDouble("Please enter b: ");
        double c = console.readDouble("Please enter c: ");

        if (a == 0) {
            if (b == 0) {
                System.out.println(c == 0 ? "Every number is a solution." : "There is no solution.");
            } else {
                System.out.printf("This is linear: x = %.4f%n", -c / b);
            }
            return;
        }

        double discriminant = b * b - 4 * a * c;
        if (discriminant > 0) {
            double root = Math.sqrt(discriminant);
            System.out.printf("Two real roots: %.4f and %.4f%n",
                    (-b + root) / (2 * a), (-b - root) / (2 * a));
        } else if (discriminant == 0) {
            System.out.printf("One repeated root: %.4f%n", -b / (2 * a));
        } else {
            System.out.println("There are no real solutions.");
        }
    }
}
