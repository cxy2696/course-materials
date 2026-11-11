# CSCI 161 · Java labs

I wrote these for CSCI 161, an intro Java course. There are 30 classes and 301
self-test assertions covering console input, loops, sorting, a card deck, simple
games and graphics, fractions, vectors, and a small program menu.

## Build and run

From the repo root:

```bash
./CSCI\ 161/build.sh       # compile to CSCI 161/out
./CSCI\ 161/test.sh        # run JavaSelfTest
./CSCI\ 161/run.sh         # program menu
./CSCI\ 161/run.sh coursework.games.Chess
```

From inside the folder, drop the `CSCI\ 161/` prefix:

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

| Package | What's in it |
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
a PNG to `CSCI 161/out/`.

```bash
java -Djava.awt.headless=true -cp "CSCI 161/out" coursework.games.Checkers
java -Djava.awt.headless=true -cp "CSCI 161/out" coursework.games.Chess < /dev/null
```

Assets live in `assets/`; see [assets/README.md](assets/README.md). Chess
positions use lines like `WP a2`; pressing Enter uses the default opening.

## Tests

`JavaSelfTest` has no dependencies. It covers the three sorts, statistics,
sieve and loop bounds, name pairing, rabbit/fox validation, `Fraction`
arithmetic, `Vector` operations, cards, and the deck operations.

```text
$ ./test.sh
All 301 Java checks passed.
```

The code uses JDK 17 and no third-party libraries.
