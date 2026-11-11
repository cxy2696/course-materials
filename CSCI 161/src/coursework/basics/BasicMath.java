package coursework.basics;

/** Arithmetic examples using a photograph and a pizza. */
public final class BasicMath {

    private static final int PHOTO_BASE_CM = 10;
    private static final int PHOTO_HEIGHT_CM = 5;
    private static final double PIZZA_DIAMETER_INCHES = 8.2;

    private BasicMath() {
    }

    public static void main(String[] args) {
        photoCalculations();
        pizzaCalculations();
        partyLogic();
    }

    private static void photoCalculations() {
        int perimeter = 2 * PHOTO_BASE_CM + 2 * PHOTO_HEIGHT_CM;
        int area = PHOTO_BASE_CM * PHOTO_HEIGHT_CM;
        int difference = PHOTO_BASE_CM - PHOTO_HEIGHT_CM;
        double ratio = (double) PHOTO_BASE_CM / PHOTO_HEIGHT_CM;

        System.out.printf("A photograph is %d cm by %d cm.%n", PHOTO_BASE_CM, PHOTO_HEIGHT_CM);
        System.out.printf("  Difference between the sides: %d cm%n", difference);
        System.out.printf("  Perimeter: %d cm%n", perimeter);
        System.out.printf("  Area: %d square cm%n", area);
        System.out.printf("  Base-to-height ratio: %.2f%n", ratio);
    }

    private static void pizzaCalculations() {
        double radius = PIZZA_DIAMETER_INCHES / 2.0;
        double circumference = Math.PI * PIZZA_DIAMETER_INCHES;
        double area = Math.PI * radius * radius;
        double slicePerimeter = PIZZA_DIAMETER_INCHES + circumference / 4.0;

        System.out.printf("A pizza is %.1f inches across.%n", PIZZA_DIAMETER_INCHES);
        System.out.printf("  Radius: %.2f inches%n", radius);
        System.out.printf("  Circumference: %.2f inches%n", circumference);
        System.out.printf("  Area: %.2f square inches%n", area);
        System.out.printf("  Perimeter of one quarter: %.2f inches%n", slicePerimeter);
        System.out.printf("  Whole minus quarter perimeter: %.2f inches%n",
                circumference - slicePerimeter);
    }

    private static void partyLogic() {
        boolean takePhotograph = true;
        boolean eatPizza = false;
        boolean eatCake = !eatPizza;
        boolean isParty = (takePhotograph || eatCake) && !eatPizza;

        System.out.printf("Cake at the party: %s%n", eatCake);
        System.out.printf("Party conditions satisfied: %s%n", isParty);
    }
}
