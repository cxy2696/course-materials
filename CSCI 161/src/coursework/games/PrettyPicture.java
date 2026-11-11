package coursework.games;

import coursework.graphics.GraphicsWindow;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

/**
 * A first graphics lab: rectangles, polygons, ovals, a line, text, and an
 * image on a Swing canvas.
 */
public final class PrettyPicture {

    private static final String TITLE = "Pretty Picture";
    private static final int WIDTH = 1000;
    private static final int HEIGHT = 500;
    private static final String IMAGE_FILE_NAME = "meme.png";

    private PrettyPicture() {
    }

    public static void main(String[] args) {
        GraphicsWindow window = new GraphicsWindow(TITLE, WIDTH, HEIGHT, 0, 0);
        window.paintBackground(Color.WHITE);
        Graphics2D pen = window.getPen();

        pen.setColor(Color.BLUE);
        pen.fillRect(WIDTH / 2, HEIGHT / 4, WIDTH / 8, HEIGHT / 4);

        pen.setColor(new Color(0, 252, 244));
        pen.fillPolygon(new int[] {0, 100, 200, 100}, new int[] {400, 300, 400, 500}, 4);

        pen.setColor(Color.GREEN);
        pen.fillPolygon(new int[] {700, 800, 900}, new int[] {400, 300, 500}, 3);

        pen.setColor(Color.RED);
        pen.fillOval(0, 0, WIDTH / 8, HEIGHT / 4);

        pen.setColor(new Color(252, 0, 244));
        pen.drawLine(300, 400, 600, 400);

        pen.setColor(Color.BLACK);
        pen.drawString("Drawing is fun!", WIDTH / 2, HEIGHT / 4);

        BufferedImage meme = GraphicsWindow.loadImage(IMAGE_FILE_NAME);
        pen.drawImage(meme, WIDTH / 4, HEIGHT / 4, null);
        window.showWindow();
    }
}
