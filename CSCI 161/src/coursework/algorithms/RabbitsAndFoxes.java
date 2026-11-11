package coursework.algorithms;

import coursework.util.Console;

/**
 * Discrete-time rabbit/fox simulation.
 *
 * Rabbits grow 20% per year and are eaten at 0.5% of the rabbit-fox product;
 * foxes grow at 0.1% of that product and die at 20% per year.
 */
public final class RabbitsAndFoxes {

    private static final double RABBIT_BIRTH_RATE = 0.20;
    private static final double RABBIT_DEATH_RATE = 0.005;
    private static final double FOX_BIRTH_RATE = 0.001;
    private static final double FOX_DEATH_RATE = 0.20;

    private RabbitsAndFoxes() {
    }

    /**
     * Simulates {@code years} years and returns {@code [rabbits, foxes]}.
     */
    public static int[][] simulate(int years, int initialRabbits, int initialFoxes) {
        if (years < 0) {
            throw new IllegalArgumentException("years must not be negative");
        }
        if (initialRabbits < 0 || initialFoxes < 0) {
            throw new IllegalArgumentException("initial populations must not be negative");
        }
        int[] rabbits = new int[years + 1];
        int[] foxes = new int[years + 1];
        rabbits[0] = initialRabbits;
        foxes[0] = initialFoxes;

        double rabbitPopulation = initialRabbits;
        double foxPopulation = initialFoxes;
        for (int year = 1; year <= years; year++) {
            double nextRabbits = rabbitPopulation
                    + RABBIT_BIRTH_RATE * rabbitPopulation
                    - RABBIT_DEATH_RATE * rabbitPopulation * foxPopulation;
            double nextFoxes = foxPopulation
                    + FOX_BIRTH_RATE * rabbitPopulation * foxPopulation
                    - FOX_DEATH_RATE * foxPopulation;
            rabbitPopulation = clampPopulation(nextRabbits);
            foxPopulation = clampPopulation(nextFoxes);
            rabbits[year] = (int) Math.round(rabbitPopulation);
            foxes[year] = (int) Math.round(foxPopulation);
        }
        return new int[][] {rabbits, foxes};
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            System.out.println("Welcome to the rabbit and fox program!");
            int years = console.readNonNegativeInt("How many years of simulation do you want? ");
            int initialRabbits = console.readNonNegativeInt("Please enter the initial rabbit population: ");
            int initialFoxes = console.readNonNegativeInt("Please enter the initial fox population: ");

            int[][] populations = simulate(years, initialRabbits, initialFoxes);
            int[] rabbits = populations[0];
            int[] foxes = populations[1];
            System.out.printf("%n%-6s %10s %10s%n", "Year", "Rabbits", "Foxes");
            for (int year = 0; year < rabbits.length; year++) {
                System.out.printf("%-6d %10d %10d%n", year, rabbits[year], foxes[year]);
            }
        }
    }

    private static double clampPopulation(double population) {
        return Math.max(0.0, Math.min(Integer.MAX_VALUE, population));
    }
}
