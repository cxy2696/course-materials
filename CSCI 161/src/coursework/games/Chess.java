package coursework.games;

import coursework.graphics.GraphicsWindow;
import coursework.util.Console;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Draws a chess position described by a small text file.
 *
 * <p>Each non-empty line has the form {@code WP a2} or {@code BK e8}: a colour
 * letter ({@code W}/{@code B}), a piece letter
 * ({@code P N B R Q K}), and a square.  A sample position is included in
 * {@code java/assets/chess-start.cp}.</p>
 */
public final class Chess {

    private static final String TITLE = "Chess";
    private static final int BOARD_SIZE = 8;
    private static final int SQUARE_SIZE = 80;
    private static final int PIECE_SIZE = 68;
    private static final int WINDOW_SIZE = BOARD_SIZE * SQUARE_SIZE;
    private static final int PIECE_OFFSET = (SQUARE_SIZE - PIECE_SIZE) / 2;
    private static final String DEFAULT_POSITION = "chess-start.cp";
    private static final Pattern POSITION_LINE =
            Pattern.compile("^([WB])([PNBRQK])\\s+([a-h])([1-8])$");
    private static final Map<Character, Integer> PIECE_COLUMN = Map.of(
            'P', 0, 'N', 1, 'B', 2, 'R', 3, 'Q', 4, 'K', 5);

    private Chess() {
    }

    public static void main(String[] args) {
        String fileName;
        try (Console console = new Console()) {
            fileName = console.readLine(
                    "Chess position file [" + DEFAULT_POSITION + "]: ");
            if (fileName.isBlank()) {
                fileName = DEFAULT_POSITION;
            }
        }

        Path positionPath = GraphicsWindow.resolveAssetPath(fileName);
        List<String> lines;
        try {
            lines = Files.readAllLines(positionPath);
        } catch (IOException exception) {
            throw new UncheckedIOException("could not read " + positionPath, exception);
        }

        GraphicsWindow window = new GraphicsWindow(TITLE, WINDOW_SIZE, WINDOW_SIZE, 0, 0);
        Graphics2D pen = window.getPen();
        drawBoard(pen);

        BufferedImage[][] pieces = GraphicsWindow.loadImageAsTiles(
                "chess-pieces.png", PIECE_SIZE, PIECE_SIZE);
        int drawn = 0;
        for (String line : lines) {
            String trimmed = line.trim();
            if (trimmed.isEmpty() || trimmed.startsWith("#")) {
                continue;
            }
            Matcher matcher = POSITION_LINE.matcher(trimmed);
            if (!matcher.matches()) {
                System.out.println("Skipping unrecognised position line: " + trimmed);
                continue;
            }
            boolean white = matcher.group(1).charAt(0) == 'W';
            int pieceColumn = PIECE_COLUMN.get(matcher.group(2).charAt(0));
            int file = matcher.group(3).charAt(0) - 'a';
            int rank = matcher.group(4).charAt(0) - '0';
            int x = file * SQUARE_SIZE + PIECE_OFFSET;
            int y = (BOARD_SIZE - rank) * SQUARE_SIZE + PIECE_OFFSET;
            pen.drawImage(pieces[white ? 0 : 1][pieceColumn], x, y, null);
            drawn++;
        }
        System.out.printf("Drew %d pieces from %s.%n", drawn, positionPath);
        window.showWindow();
    }

    private static void drawBoard(Graphics2D pen) {
        Color lightSquare = new Color(255, 226, 163);
        Color darkSquare = new Color(201, 119, 10);
        for (int row = 0; row < BOARD_SIZE; row++) {
            for (int column = 0; column < BOARD_SIZE; column++) {
                pen.setColor((row + column) % 2 == 0 ? lightSquare : darkSquare);
                pen.fillRect(column * SQUARE_SIZE, row * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
            }
        }
    }
}
