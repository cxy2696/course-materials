package coursework.basics;

import coursework.util.Console;

/**
 * A short scripted conversation that demonstrates reading strings and numbers
 * from the console.
 */
public final class Conversation {

    private Conversation() {
    }

    public static void main(String[] args) {
        try (Console console = new Console()) {
            String name = console.readNonBlank("Hi! What's your name? ");
            System.out.println("Hello, " + name + ". It's nice to meet you.");

            String birthday = console.readNonBlank("What's your birthday? ");
            System.out.println("Birthday noted: " + birthday + ".");

            String gift = console.readNonBlank("What would you like for your birthday? ");
            double cost = console.readDouble("How much does " + gift + " cost? ");

            System.out.printf("That's expensive! We can contribute $%.2f.%n", Math.max(0.0, cost - 1.0));
            console.readInt("How would you rate this conversation (1-10)? ", 1, 10);
            System.out.println("Thanks for your time! See you!");
        }
    }
}
