package coursework;

import coursework.algorithms.BubbleSort;
import coursework.algorithms.Business;
import coursework.algorithms.Partners;
import coursework.algorithms.RabbitsAndFoxes;
import coursework.algorithms.SelectionSort;
import coursework.algorithms.ShakerSort;
import coursework.algorithms.SieveOfEratosthenes;
import coursework.basics.BasicMath;
import coursework.basics.Calculator;
import coursework.basics.Conversation;
import coursework.basics.HelloWorld;
import coursework.basics.IfMath;
import coursework.basics.LoopMath1;
import coursework.basics.LoopMath2;
import coursework.basics.StringManipulation;
import coursework.cards.Shuffler;
import coursework.games.Checkers;
import coursework.games.Chess;
import coursework.games.Fantasy;
import coursework.games.PrettyPicture;
import coursework.util.Console;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Locale;

/**
 * Interactive index of every runnable program in the Java collection.
 *
 * <p>Run with no arguments for a menu, or with a program id to start it
 * directly, for example:</p>
 * <pre>{@code
 * java -cp java/out coursework.Coursework
 * java -cp java/out coursework.Coursework algorithms.sieve
 * }</pre>
 */
public final class Coursework {

    private record Program(String id, String description, Class<?> type) {
    }

    private static final List<Program> PROGRAMS = List.of(
            new Program("basics.hello", "Hello, world", HelloWorld.class),
            new Program("basics.math", "Photo and pizza arithmetic", BasicMath.class),
            new Program("basics.calculator", "Four-function calculator", Calculator.class),
            new Program("basics.conversation", "Scripted console conversation", Conversation.class),
            new Program("basics.if", "Even/odd, quadrants, quadratics", IfMath.class),
            new Program("basics.loop1", "Repeated x, powers of two, primes", LoopMath1.class),
            new Program("basics.loop2", "Odd numbers, factorial, Fibonacci", LoopMath2.class),
            new Program("basics.strings", "String operations", StringManipulation.class),
            new Program("algorithms.bubble", "Bubble sort benchmark", BubbleSort.class),
            new Program("algorithms.selection", "Selection sort benchmark", SelectionSort.class),
            new Program("algorithms.shaker", "Shaker sort benchmark", ShakerSort.class),
            new Program("algorithms.sieve", "Sieve of Eratosthenes", SieveOfEratosthenes.class),
            new Program("algorithms.partners", "Every pairing of a name list", Partners.class),
            new Program("algorithms.business", "Daily profit statistics", Business.class),
            new Program("algorithms.rabbits", "Rabbits and foxes simulation", RabbitsAndFoxes.class),
            new Program("cards.shuffler", "Draw a shuffled hand", Shuffler.class),
            new Program("games.checkers", "Draw a checkers board", Checkers.class),
            new Program("games.chess", "Draw a chess position", Chess.class),
            new Program("games.fantasy", "Draw a random tile map", Fantasy.class),
            new Program("games.picture", "Draw shapes, text, and an image", PrettyPicture.class));

    private Coursework() {
    }

    public static void main(String[] args) throws Exception {
        if (args.length > 0) {
            Program program = find(args[0]);
            if (program == null) {
                System.err.println("Unknown program: " + args[0]);
                printMenu();
                return;
            }
            run(program);
            return;
        }

        try (Console console = new Console()) {
            printMenu();
            int choice = console.readInt("Choose a program (1-" + PROGRAMS.size() + "): ",
                    1, PROGRAMS.size());
            run(PROGRAMS.get(choice - 1));
        }
    }

    private static Program find(String name) {
        String normalized = name.toLowerCase(Locale.ROOT);
        for (Program program : PROGRAMS) {
            if (program.id().equals(normalized)
                    || program.type().getSimpleName().equalsIgnoreCase(name)) {
                return program;
            }
        }
        return null;
    }

    private static void printMenu() {
        System.out.println("CSCI 161 / Java coursework collection");
        System.out.println("=====================================");
        for (int index = 0; index < PROGRAMS.size(); index++) {
            Program program = PROGRAMS.get(index);
            System.out.printf("%2d. %-22s %s%n", index + 1, program.id(), program.description());
        }
    }

    private static void run(Program program) throws Exception {
        Method main = program.type().getMethod("main", String[].class);
        try {
            main.invoke(null, (Object) new String[0]);
        } catch (InvocationTargetException exception) {
            Throwable cause = exception.getCause();
            if (cause instanceof Exception checked) {
                throw checked;
            }
            throw exception;
        }
    }
}
