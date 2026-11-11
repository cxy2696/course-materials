# Graphics assets

| File | Source | Used by |
| --- | --- | --- |
| `meme.png` | original archive | `PrettyPicture` |
| `cards.png` | generated | `Shuffler` |
| `chess-pieces.png` | generated | `Chess` |
| `terrain.png`, `wizard.png` | generated | `Fantasy` |
| `chess-start.cp` | generated | default `Chess` position |

Sizes must match the Java constants:

- `cards.png`: 1560×672, 13 columns × 4 rows, 120×168 per card;
- `chess-pieces.png`: 408×136, 6 columns × 2 rows, 68×68 per piece;
- `terrain.png`: 384×64, six 64×64 tiles;
- `wizard.png`: 64×64.

Regenerate the generated files with:

```bash
python -m pip install Pillow
python "CSCI 161/scripts/generate_assets.py"
```

If you replace an image, keep the name and dimensions; otherwise update the
constants in `Shuffler`, `Chess`, and `Fantasy`.
