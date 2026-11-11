package coursework.algorithms;

/** Interactive shaker (cocktail) sort demo. */
public final class ShakerSort {

    private ShakerSort() {
    }

    public static void main(String[] args) {
        SortDemo.run("Shaker sort", Sorting::shakerSort);
    }
}
