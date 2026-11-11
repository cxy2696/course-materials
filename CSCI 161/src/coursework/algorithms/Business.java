package coursework.algorithms;

import coursework.util.Console;
import java.util.Arrays;

/**
 * Daily-profit statistics: average, population standard deviation, best day,
 * and worst day.
 */
public final class Business {

    private Business() {
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            System.out.println("Welcome to the profit-calculation program.");
            int days = console.readPositiveInt("How many days' data do you have? ");
            double[] profits = new double[days];
            System.out.println("What was the profit on each day?");
            for (int day = 0; day < days; day++) {
                profits[day] = console.readDouble("  Day " + (day + 1) + ": ");
            }

            double average = Statistics.average(profits);
            double deviation = Statistics.standardDeviation(profits);
            double best = Statistics.max(profits);
            double worst = Statistics.min(profits);
            int bestDay = Statistics.indexOfMax(profits) + 1;
            int worstDay = Statistics.indexOfMin(profits) + 1;

            System.out.printf("Your average profit was $%.2f (plus or minus $%.2f).%n",
                    average, deviation);
            System.out.printf("The best day was Day %d, when you made $%.2f.%n", bestDay, best);
            System.out.printf("The worst day was Day %d, when you made $%.2f.%n", worstDay, worst);
            System.out.println("Daily profits: " + Arrays.toString(profits));
        }
    }
}
