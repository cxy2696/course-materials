# CSCI 161 · Java labs

30 Java classes and 301 self-test assertions. The examples cover console input,
loops, sorting, a card deck, simple game/graphics programs, fractions, vectors,
and a small program menu.

## Build and run

```bash
./CSCI\ 161/build.sh       # compile to CSCI 161/out
./CSCI\ 161/test.sh        # run JavaSelfTest
./CSCI\ 161/run.sh         # program menu
./CSCI\ 161/run.sh coursework.games.Chess
```

From inside this folder, drop the `CSCI\ 161/` prefix:

```bash
./build.sh
./test.sh
```

Manual compile:

```bash
javac --release 17 -d "CSCI 161/out" $(find "CSCI 161/src" -name '*.java')
java -cp "CSCI 161/out" coursework.Coursework
```

## Packages

| Package | Contents |
| --- | --- |
| `coursework` | `Coursework`, the numbered menu for 20 programs |
| `coursework.basics` | HelloWorld, arithmetic, calculator, conversation, conditionals, loops, strings |
| `coursework.algorithms` | three sorts, sieve, name pairings, business statistics, rabbit/fox simulation |
| `coursework.cards` | `Card`, `CardSet`, `Shuffler` |
| `coursework.games` | `Checkers`, `Chess`, `Fantasy`, `PrettyPicture` |
| `coursework.oop` | `Fraction`, `Vector` |
| `coursework.graphics` | `GraphicsWindow` (off-screen canvas + Swing window) |
| `coursework.util` | `Console`, validated integer/decimal/yes-no input |

The menu has 8 basic programs, 7 algorithm programs, 1 card demo, and 4 graphics
programs.

## Graphics

`Checkers`, `Chess`, `Fantasy`, `PrettyPicture`, and `Shuffler` use
`GraphicsWindow`. With a display they open a Swing window; without one they save
to `CSCI 161/out/<title>.png`.

```bash
java -Djava.awt.headless=true -cp "CSCI 161/out" coursework.games.Checkers
java -Djava.awt.headless=true -cp "CSCI 161/out" coursework.games.Chess < /dev/null
```

Assets live in `assets/`; see [assets/README.md](assets/README.md). Chess
positions use lines such as `WP a2`; pressing Enter uses the default opening.

## Tests

`JavaSelfTest` is dependency-free and covers:

- all three sorts (empty, one element, duplicates, reverse, random);
- mean, variance, standard deviation, min/max, first occurrence;
- sieve bounds, loop-math bounds and overflow;
- name pairing and rabbit/fox validation;
- `Fraction` reduction, arithmetic, comparison, zero denominator;
- `Vector` dot/cross/normalization/angle, zero vector;
- `Card` comparison, rank/suit, random cards, invalid input;
- `CardSet` standard deck, shuffle, discard, unmodifiable view.

```text
$ ./test.sh
All 301 Java checks passed.
```

The implementation uses JDK 17 and no third-party libraries.
