package coursework.oop;

/** A mutable three-dimensional vector. */
public final class Vector {

    private double x;
    private double y;
    private double z;

    /** Creates a vector from its components. */
    public Vector(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    /** Returns {@code this + other}. */
    public Vector add(Vector other) {
        requireNonNull(other);
        return new Vector(x + other.x, y + other.y, z + other.z);
    }

    /** Returns {@code this - other}. */
    public Vector subtract(Vector other) {
        requireNonNull(other);
        return new Vector(x - other.x, y - other.y, z - other.z);
    }

    /** Returns {@code this * scalar}. */
    public Vector multiply(double scalar) {
        return new Vector(x * scalar, y * scalar, z * scalar);
    }

    /** Returns the cross product {@code this × other}. */
    public Vector cross(Vector other) {
        requireNonNull(other);
        return new Vector(
                y * other.z - z * other.y,
                z * other.x - x * other.z,
                x * other.y - y * other.x);
    }

    /** Returns the dot product {@code this · other}. */
    public double dot(Vector other) {
        requireNonNull(other);
        return x * other.x + y * other.y + z * other.z;
    }

    /** Returns the Euclidean length. */
    public double length() {
        return Math.sqrt(x * x + y * y + z * z);
    }

    /** Returns a unit vector with the same direction. */
    public Vector normalized() {
        double length = length();
        if (length == 0.0) {
            throw new ArithmeticException("cannot normalize a zero-length vector");
        }
        return multiply(1.0 / length);
    }

    /** Returns the angle to {@code other} in radians, in {@code [0, π]}. */
    public double angleBetween(Vector other) {
        requireNonNull(other);
        double denominator = length() * other.length();
        if (denominator == 0.0) {
            throw new ArithmeticException("cannot compute an angle with a zero-length vector");
        }
        double cosine = dot(other) / denominator;
        cosine = Math.max(-1.0, Math.min(1.0, cosine));
        return Math.acos(cosine);
    }

    /** Returns the x component. */
    public double getX() {
        return x;
    }

    /** Returns the y component. */
    public double getY() {
        return y;
    }

    /** Returns the z component. */
    public double getZ() {
        return z;
    }

    /** Sets the x component. */
    public void setX(double newX) {
        x = newX;
    }

    /** Sets the y component. */
    public void setY(double newY) {
        y = newY;
    }

    /** Sets the z component. */
    public void setZ(double newZ) {
        z = newZ;
    }

    @Override
    public boolean equals(Object otherObject) {
        if (this == otherObject) {
            return true;
        }
        if (!(otherObject instanceof Vector other)) {
            return false;
        }
        return Double.compare(x, other.x) == 0
                && Double.compare(y, other.y) == 0
                && Double.compare(z, other.z) == 0;
    }

    @Override
    public int hashCode() {
        int result = Double.hashCode(x);
        result = 31 * result + Double.hashCode(y);
        result = 31 * result + Double.hashCode(z);
        return result;
    }

    @Override
    public String toString() {
        return "(" + x + ", " + y + ", " + z + ")";
    }

    private static void requireNonNull(Vector other) {
        if (other == null) {
            throw new IllegalArgumentException("other vector must not be null");
        }
    }
}
