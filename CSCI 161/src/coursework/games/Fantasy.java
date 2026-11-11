package coursework.games;

import coursework.graphics.GraphicsWindow;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Random;

/**
 * Draws a small tile map with a wizard in the middle.
 *
 * <p>The terrain tiles come from a horizontal strip; the wizard is a separate
 * image.  Random placement uses a seeded {@link Random} so a run can be
 * reproduced by changing the seed.</p>
 */
public final class Fantasy {

    private static final String TITLE = "Fantasy Game!";
    private static final int TILE_SIZE = 64;
    private static final int MAP_SIZE = 11;
    private static final int WIDTH = MAP_SIZE * TILE_SIZE;
    private static final int HEIGHT = MAP_SIZE * TILE_SIZE;
    private static final String TERRAIN_FILE = "terrain.png";
    private static final String WIZARD_FILE = "wizard.png";
    private static final long RANDOM_SEED = 42L;

    private Fantasy() {
    }

    public static void main(String[] args) {
        GraphicsWindow window = new GraphicsWindow(TITLE, WIDTH, HEIGHT, 50, 50);
        Graphics2D pen = window.getPen();

        BufferedImage[] terrains = GraphicsWindow.loadImageAsTiles(TERRAIN_FILE, TILE_SIZE);
        Random random = new Random(RANDOM_SEED);
        for (int row = 0; row < MAP_SIZE; row++) {
            for (int column = 0; column < MAP_SIZE; column++) {
                BufferedImage tile = terrains[random.nextInt(terrains.length)];
                pen.drawImage(tile, column * TILE_SIZE, row * TILE_SIZE, null);
            }
        }

        BufferedImage wizard = GraphicsWindow.loadImage(WIZARD_FILE);
        int center = (MAP_SIZE / 2) * TILE_SIZE;
        pen.drawImage(wizard, center, center, null);
        window.showWindow();
    }
}
