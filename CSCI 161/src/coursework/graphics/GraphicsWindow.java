package coursework.graphics;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.SwingUtilities;

/**
 * Off-screen drawing surface displayed in a Swing window.
 *
 * In a headless environment the drawing is saved to {@code java/out/}.
 */
public final class GraphicsWindow {

    private final String title;
    private final int x;
    private final int y;
    private final BufferedImage canvas;
    private final Graphics2D pen;
    private JFrame frame;

    /**
     * Creates a window-sized drawing surface.
     *
     * @param title  window title, also used as the file name in headless mode
     * @param width  canvas width in pixels
     * @param height canvas height in pixels
     * @param x      initial window x position
     * @param y      initial window y position
     */
    public GraphicsWindow(String title, int width, int height, int x, int y) {
        if (width <= 0 || height <= 0) {
            throw new IllegalArgumentException("width and height must be positive");
        }
        this.title = title == null || title.isBlank() ? "Graphics Window" : title;
        this.x = x;
        this.y = y;
        this.canvas = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        this.pen = canvas.createGraphics();
        this.pen.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        this.pen.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        this.pen.setColor(Color.WHITE);
        this.pen.fillRect(0, 0, width, height);
    }

    /** Returns the pen used to draw on the canvas. */
    public Graphics2D getPen() {
        return pen;
    }

    /** Fills the whole canvas with {@code color}. */
    public void paintBackground(Color color) {
        Color previous = pen.getColor();
        pen.setColor(color);
        pen.fillRect(0, 0, canvas.getWidth(), canvas.getHeight());
        pen.setColor(previous);
    }

    /**
     * Shows the drawing.  In a headless environment the canvas is saved as a
     * PNG under {@code java/out/} and the path is printed.
     */
    public void showWindow() {
        pen.dispose();
        if (GraphicsEnvironment.isHeadless()) {
            Path directory = codeSourceDirectory();
            if (directory == null || !Files.isDirectory(directory)) {
                directory = Paths.get("out");
            }
            Path output = directory.resolve(safeFileName(title) + ".png");
            savePng(output);
            System.out.println("No display detected; drawing saved to " + output.toAbsolutePath());
            return;
        }
        SwingUtilities.invokeLater(() -> {
            frame = new JFrame(title);
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.add(new JLabel(new ImageIcon(canvas)));
            frame.pack();
            frame.setLocation(x, y);
            frame.setVisible(true);
        });
    }

    /** Closes the window if one was opened. */
    public void close() {
        if (frame != null) {
            SwingUtilities.invokeLater(frame::dispose);
        }
    }

    /** Saves the current canvas as a PNG, creating parent directories. */
    public void savePng(Path path) {
        try {
            Path parent = path.toAbsolutePath().getParent();
            if (parent != null) {
                Files.createDirectories(parent);
            }
            if (!ImageIO.write(canvas, "png", path.toFile())) {
                throw new IOException("no PNG writer available");
            }
        } catch (IOException exception) {
            throw new UncheckedIOException("could not save image to " + path, exception);
        }
    }

    /**
     * Loads an image from the working directory, {@code assets/}, or
     * {@code java/assets/}.  The search order makes the labs runnable both
     * from the repository root and from the {@code java} directory.
     */
    public static BufferedImage loadImage(String fileName) {
        Path path = resolveAssetPath(fileName);
        try {
            BufferedImage image = ImageIO.read(path.toFile());
            if (image == null) {
                throw new IllegalArgumentException("not a readable image: " + path);
            }
            return image;
        } catch (IOException exception) {
            throw new UncheckedIOException("could not read image: " + path, exception);
        }
    }

    /**
     * Splits an image into square tiles laid out in a single horizontal row.
     *
     * @param fileName image path understood by {@link #loadImage(String)}
     * @param tileSize width and height of one tile
     * @return tiles from left to right
     */
    public static BufferedImage[] loadImageAsTiles(String fileName, int tileSize) {
        BufferedImage[][] grid = loadImageAsTiles(fileName, tileSize, tileSize);
        BufferedImage[] tiles = new BufferedImage[grid.length * grid[0].length];
        int index = 0;
        for (BufferedImage[] row : grid) {
            for (BufferedImage tile : row) {
                tiles[index++] = tile;
            }
        }
        return tiles;
    }

    /**
     * Splits an image into a grid of equally sized tiles.
     *
     * @param fileName image path understood by {@link #loadImage(String)}
     * @param tileWidth  width of one tile
     * @param tileHeight height of one tile
     * @return {@code [row][column]} tiles, top-left first
     */
    public static BufferedImage[][] loadImageAsTiles(String fileName, int tileWidth, int tileHeight) {
        if (tileWidth <= 0 || tileHeight <= 0) {
            throw new IllegalArgumentException("tile dimensions must be positive");
        }
        BufferedImage image = loadImage(fileName);
        int columns = image.getWidth() / tileWidth;
        int rows = image.getHeight() / tileHeight;
        if (columns == 0 || rows == 0) {
            throw new IllegalArgumentException(
                    "image %s (%dx%d) is smaller than one %dx%d tile"
                            .formatted(fileName, image.getWidth(), image.getHeight(), tileWidth, tileHeight));
        }
        BufferedImage[][] tiles = new BufferedImage[rows][columns];
        for (int row = 0; row < rows; row++) {
            for (int column = 0; column < columns; column++) {
                tiles[row][column] = image.getSubimage(
                        column * tileWidth, row * tileHeight, tileWidth, tileHeight);
            }
        }
        return tiles;
    }

    /**
     * Resolves an asset name against the working directory, {@code assets/},
     * {@code java/assets/}, and the directory that contains the compiled
     * classes.
     */
    public static Path resolveAssetPath(String fileName) {
        if (fileName == null || fileName.isBlank()) {
            throw new IllegalArgumentException("asset file name must not be blank");
        }
        List<Path> candidates = new ArrayList<>();
        candidates.add(Paths.get(fileName));
        candidates.add(Paths.get("assets", fileName));
        candidates.add(Paths.get("java", "assets", fileName));

        Path codeLocation = codeSourceDirectory();
        if (codeLocation != null) {
            candidates.add(codeLocation.resolve("assets").resolve(fileName));
            candidates.add(codeLocation.resolve("..").resolve("assets").resolve(fileName).normalize());
        }
        for (Path candidate : candidates) {
            if (Files.isRegularFile(candidate)) {
                return candidate;
            }
        }
        throw new IllegalArgumentException(
                "asset not found: " + fileName + " (looked in " + candidates + ")");
    }

    private static Path codeSourceDirectory() {
        try {
            var source = GraphicsWindow.class.getProtectionDomain().getCodeSource();
            if (source == null) {
                return null;
            }
            return Paths.get(source.getLocation().toURI());
        } catch (Exception ignored) {
            return null;
        }
    }

    private static String safeFileName(String value) {
        return value.toLowerCase(Locale.ROOT).replaceAll("[^a-z0-9]+", "-").replaceAll("^-+|-+$", "");
    }
}
