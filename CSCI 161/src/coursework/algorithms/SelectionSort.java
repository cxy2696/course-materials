package coursework.algorithms;

/** Interactive selection-sort demo. */
public final class SelectionSort {

    private SelectionSort() {
    }

    public static void main(String[] args) {
        SortDemo.run("Selection sort", Sorting::selectionSort);
    }
}
