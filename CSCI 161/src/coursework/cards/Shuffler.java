package coursework.cards;

import coursework.graphics.GraphicsWindow;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

/** Shows a freshly shuffled hand of cards. */
public final class Shuffler {

    private static final String TITLE = "Shuffled Cards";
    private static final int IMAGE_WIDTH = 1560;
    private static final int IMAGE_HEIGHT = 672;
    private static final int CARD_COLUMNS = 13;
    private static final int CARD_ROWS = 4;
    private static final int CARD_WIDTH = IMAGE_WIDTH / CARD_COLUMNS;
    private static final int CARD_HEIGHT = IMAGE_HEIGHT / CARD_ROWS;
    private static final int VISIBLE_CARDS = 9;
    private static final int MARGIN = 10;
    private static final int WINDOW_WIDTH = CARD_WIDTH * VISIBLE_CARDS + 2 * MARGIN;
    private static final int WINDOW_HEIGHT = CARD_HEIGHT + 2 * MARGIN;
    private static final Color BOARD = new Color(0, 117, 37);
    private static final String IMAGE_FILE_NAME = "cards.png";

    private Shuffler() {
    }

    public static void main(String[] args) {
        GraphicsWindow window = new GraphicsWindow(TITLE, WINDOW_WIDTH, WINDOW_HEIGHT, 60, 60);
        window.paintBackground(BOARD);
        Graphics2D pen = window.getPen();

        BufferedImage[][] cardImages = GraphicsWindow.loadImageAsTiles(
                IMAGE_FILE_NAME, CARD_WIDTH, CARD_HEIGHT);
        Card.setDefaultImages(cardImages);

        CardSet deck = CardSet.makeStandardDeck();
        deck.shuffle();
        deck.draw(pen, MARGIN, MARGIN, VISIBLE_CARDS);

        System.out.println("Top " + VISIBLE_CARDS + " cards after shuffling:");
        deck.asList().stream().limit(VISIBLE_CARDS)
                .forEach(card -> System.out.println("  " + card));

        window.showWindow();
    }
}
