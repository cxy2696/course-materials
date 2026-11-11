package coursework.cards;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Objects;
import java.util.concurrent.ThreadLocalRandom;

/** A playing card with a rank, a suit, and optional artwork. */
public class Card implements Comparable<Card> {

    /** Lowest rank (ace). */
    public static final int ACE = 1;
    /** Rank of the jack. */
    public static final int JACK = 11;
    /** Rank of the queen. */
    public static final int QUEEN = 12;
    /** Highest rank (king). */
    public static final int KING = 13;

    /** Suit index for clubs. */
    public static final int CLUBS = 0;
    /** Suit index for diamonds. */
    public static final int DIAMONDS = 1;
    /** Suit index for spades. */
    public static final int SPADES = 2;
    /** Suit index for hearts. */
    public static final int HEARTS = 3;

    private static final String[] SUIT_NAMES = {"Clubs", "Diamonds", "Spades", "Hearts"};
    private static volatile BufferedImage[][] defaultImages;

    private final int rank;
    private final int suit;
    private final BufferedImage image;

    /**
     * Creates a card with explicit artwork.
     *
     * @param rank  rank in {@code [ACE, KING]}
     * @param suit  suit in {@code [CLUBS, HEARTS]}
     * @param image artwork, or {@code null} to use the default artwork
     */
    public Card(int rank, int suit, BufferedImage image) {
        validateRankAndSuit(rank, suit);
        this.rank = rank;
        this.suit = suit;
        this.image = image != null ? image : defaultImageFor(rank, suit);
    }

    /**
     * Creates a card using the default artwork, if one has been installed with
     * {@link #setDefaultImages(BufferedImage[][])}.
     */
    public Card(int rank, int suit) {
        this(rank, suit, null);
    }

    /** Creates a random card. */
    public Card() {
        this(ThreadLocalRandom.current().nextInt(ACE, KING + 1),
                ThreadLocalRandom.current().nextInt(CLUBS, HEARTS + 1));
    }

    /**
     * Installs the artwork used by cards created without an explicit image.
     * The array must be indexed as {@code [suit][rank - ACE]} and contain
     * exactly four rows of thirteen images.
     */
    public static void setDefaultImages(BufferedImage[][] cardImages) {
        Objects.requireNonNull(cardImages, "cardImages");
        if (cardImages.length != 4) {
            throw new IllegalArgumentException("expected 4 suit rows, got " + cardImages.length);
        }
        for (int suit = 0; suit < cardImages.length; suit++) {
            if (cardImages[suit] == null || cardImages[suit].length != 13) {
                throw new IllegalArgumentException("suit row " + suit + " must contain 13 images");
            }
        }
        defaultImages = cardImages;
    }

    /** Returns the artwork, or {@code null} if none is available. */
    public BufferedImage getImage() {
        return image;
    }

    /** Returns the artwork width, or {@code 0} when there is no artwork. */
    public int getImageWidth() {
        return image == null ? 0 : image.getWidth();
    }

    /** Returns the artwork height, or {@code 0} when there is no artwork. */
    public int getImageHeight() {
        return image == null ? 0 : image.getHeight();
    }

    /** Draws the card at {@code (x, y)}. */
    public void draw(Graphics2D pen, int x, int y) {
        Objects.requireNonNull(pen, "pen");
        if (image == null) {
            throw new IllegalStateException("no artwork for " + this
                    + "; call Card.setDefaultImages(...) first");
        }
        pen.drawImage(image, x, y, null);
    }

    /** Returns the rank. */
    public int getRank() {
        return rank;
    }

    /** Returns the suit. */
    public int getSuit() {
        return suit;
    }

    /** Returns {@code true} for jack, queen, and king. */
    public boolean isFaceCard() {
        return rank == JACK || rank == QUEEN || rank == KING;
    }

    /** Returns {@code true} for hearts and diamonds. */
    public boolean isRed() {
        return suit == HEARTS || suit == DIAMONDS;
    }

    /** Returns {@code true} for clubs and spades. */
    public boolean isBlack() {
        return suit == CLUBS || suit == SPADES;
    }

    /** Returns {@code true} if both cards have the same rank. */
    public boolean hasSameRank(Card other) {
        return other != null && rank == other.rank;
    }

    /** Returns {@code true} if both cards have the same suit. */
    public boolean hasSameSuit(Card other) {
        return other != null && suit == other.suit;
    }

    /** Returns {@code true} if this card outranks {@code other}. */
    public boolean hasGreaterRank(Card other) {
        return other != null && rank > other.rank;
    }

    /** Returns {@code true} if this card is outranked by {@code other}. */
    public boolean hasLesserRank(Card other) {
        return other != null && rank < other.rank;
    }

    /** Returns the rank label. */
    public String getRankName() {
        return switch (rank) {
            case ACE -> "Ace";
            case JACK -> "Jack";
            case QUEEN -> "Queen";
            case KING -> "King";
            default -> Integer.toString(rank);
        };
    }

    /** Returns the suit label. */
    public String getSuitName() {
        return SUIT_NAMES[suit];
    }

    @Override
    public int compareTo(Card other) {
        Objects.requireNonNull(other, "other");
        int rankComparison = Integer.compare(rank, other.rank);
        return rankComparison != 0 ? rankComparison : Integer.compare(suit, other.suit);
    }

    @Override
    public boolean equals(Object otherObject) {
        if (this == otherObject) {
            return true;
        }
        if (!(otherObject instanceof Card other)) {
            return false;
        }
        return rank == other.rank && suit == other.suit;
    }

    @Override
    public int hashCode() {
        return 31 * rank + suit;
    }

    @Override
    public String toString() {
        return getRankName() + " of " + getSuitName();
    }

    private static void validateRankAndSuit(int rank, int suit) {
        if (rank < ACE || rank > KING) {
            throw new IllegalArgumentException("rank must be between " + ACE + " and " + KING + ": " + rank);
        }
        if (suit < CLUBS || suit > HEARTS) {
            throw new IllegalArgumentException("suit must be between " + CLUBS + " and " + HEARTS + ": " + suit);
        }
    }

    private static BufferedImage defaultImageFor(int rank, int suit) {
        BufferedImage[][] images = defaultImages;
        return images == null ? null : images[suit][rank - ACE];
    }
}
