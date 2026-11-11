package coursework.cards;

import java.awt.Graphics2D;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Random;

/** An ordered collection of cards. */
public final class CardSet {

    private final List<Card> cards;

    /** Creates an empty card set. */
    public CardSet() {
        this.cards = new ArrayList<>();
    }

    /** Adds a card to the end of the set. */
    public void add(Card card) {
        cards.add(Objects.requireNonNull(card, "card"));
    }

    /**
     * Removes and returns the card at {@code index}.
     *
     * @throws IndexOutOfBoundsException if {@code index} is not a valid index
     */
    public Card discard(int index) {
        return cards.remove(index);
    }

    /** Returns the number of cards. */
    public int getSize() {
        return cards.size();
    }

    /** Returns {@code true} when the set contains no cards. */
    public boolean isEmpty() {
        return cards.isEmpty();
    }

    /** Removes every card. */
    public void clear() {
        cards.clear();
    }

    /** Returns an unmodifiable view of the cards. */
    public List<Card> asList() {
        return Collections.unmodifiableList(cards);
    }

    /** Shuffles the set using a fresh random source. */
    public void shuffle() {
        Collections.shuffle(cards);
    }

    /** Shuffles the set using {@code random}; useful for reproducible tests. */
    public void shuffle(Random random) {
        Collections.shuffle(cards, Objects.requireNonNull(random, "random"));
    }

    /** Creates a standard 52-card deck in suit/rank order. */
    public static CardSet makeStandardDeck() {
        CardSet deck = new CardSet();
        for (int suit = Card.CLUBS; suit <= Card.HEARTS; suit++) {
            for (int rank = Card.ACE; rank <= Card.KING; rank++) {
                deck.add(new Card(rank, suit));
            }
        }
        return deck;
    }

    /** Draws every card in the set, left to right, starting at {@code (x, y)}. */
    public void draw(Graphics2D pen, int x, int y) {
        draw(pen, x, y, Integer.MAX_VALUE);
    }

    /**
     * Draws at most {@code maxCards} cards, left to right, starting at
     * {@code (x, y)}.  The spacing is the card artwork width, so the caller
     * should size the window accordingly.
     */
    public void draw(Graphics2D pen, int x, int y, int maxCards) {
        Objects.requireNonNull(pen, "pen");
        int limit = Math.min(Math.max(maxCards, 0), cards.size());
        int cursor = x;
        for (int index = 0; index < limit; index++) {
            Card card = cards.get(index);
            card.draw(pen, cursor, y);
            cursor += Math.max(1, card.getImageWidth());
        }
    }

    @Override
    public String toString() {
        return cards.toString();
    }
}
