package coursework.algorithms;

/** Interactive bubble-sort demo. */
public final class BubbleSort {

    private BubbleSort() {
    }

    public static void main(String[] args) {
        SortDemo.run("Bubble sort", Sorting::bubbleSort);
    }
}
