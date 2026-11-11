package coursework.games;

import coursework.graphics.GraphicsWindow;
import java.awt.Color;
import java.awt.Graphics2D;

/** Draws a checkers starting position. */
public final class Checkers {

    private static final int BOARD_SIZE = 8;
    private static final int WINDOW_SIZE = 640;
    private static final int TILE_SIZE = WINDOW_SIZE / BOARD_SIZE;
    private static final String WINDOW_TITLE = "Checkers";
    private static final Color LIGHT_SQUARE = new Color(232, 208, 168);
    private static final Color DARK_SQUARE = new Color(132, 42, 42);
    private static final Color BLACK_PIECE = new Color(50, 50, 50);
    private static final Color RED_PIECE = new Color(180, 30, 36);

    private Checkers() {
    }

    public static void main(String[] args) {
        GraphicsWindow window = new GraphicsWindow(WINDOW_TITLE, WINDOW_SIZE, WINDOW_SIZE, 0, 0);
        Graphics2D pen = window.getPen();
        drawBoard(pen);
        drawStartingPieces(pen);
        window.showWindow();
    }

    private static void drawBoard(Graphics2D pen) {
        for (int row = 0; row < BOARD_SIZE; row++) {
            for (int column = 0; column < BOARD_SIZE; column++) {
                pen.setColor((row + column) % 2 == 0 ? LIGHT_SQUARE : DARK_SQUARE);
                pen.fillRect(column * TILE_SIZE, row * TILE_SIZE, TILE_SIZE, TILE_SIZE);
            }
        }
    }

    private static void drawStartingPieces(Graphics2D pen) {
        for (int row = 0; row < BOARD_SIZE; row++) {
            for (int column = 0; column < BOARD_SIZE; column++) {
                if ((row + column) % 2 == 0) {
                    continue;
                }
                if (row <= 2) {
                    drawChecker(pen, row, column, BLACK_PIECE);
                } else if (row >= 5) {
                    drawChecker(pen, row, column, RED_PIECE);
                }
            }
        }
    }

    private static void drawChecker(Graphics2D pen, int row, int column, Color color) {
        int inset = TILE_SIZE / 8;
        int size = TILE_SIZE - 2 * inset;
        int x = column * TILE_SIZE + inset;
        int y = row * TILE_SIZE + inset;

        pen.setColor(color);
        pen.fillOval(x, y, size, size);
        pen.setColor(Color.BLACK);
        pen.drawOval(x, y, size, size);
        int innerInset = size / 4;
        pen.drawOval(x + innerInset, y + innerInset, size - 2 * innerInset, size - 2 * innerInset);
    }
}
