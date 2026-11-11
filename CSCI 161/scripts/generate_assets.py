#!/usr/bin/env python3
"""Regenerates the placeholder artwork used by the Java graphics labs.

Requires Pillow (``python -m pip install Pillow``).  The output dimensions are
chosen to match the tile sizes in the Java classes:

* cards.png        13 columns × 4 rows, 120 × 168 each
* chess-pieces.png  6 columns × 2 rows, 68 × 68 each
* terrain.png       6 tiles of 64 × 64
* wizard.png        64 × 64

This does not touch the original ``meme.png`` file.
"""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "assets"
FONT_CANDIDATES = [
    "/System/Library/Fonts/Supplemental/Arial.ttf",
    "/Library/Fonts/Arial.ttf",
    "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
]


def load_font(size: int) -> ImageFont.ImageFont:
    for candidate in FONT_CANDIDATES:
        if Path(candidate).exists():
            return ImageFont.truetype(candidate, size)
    return ImageFont.load_default()


def make_cards() -> None:
    card_width, card_height = 120, 168
    image = Image.new("RGBA", (card_width * 13, card_height * 4), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    suits = [("C", "black"), ("D", "red"), ("S", "black"), ("H", "red")]
    ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    small, large = load_font(20), load_font(42)
    for row, (symbol, color) in enumerate(suits):
        for column, rank in enumerate(ranks):
            x, y = column * card_width, row * card_height
            draw.rounded_rectangle(
                [x + 2, y + 2, x + card_width - 3, y + card_height - 3],
                radius=8, fill="white", outline="black", width=2,
            )
            draw.text((x + 10, y + 8), rank, font=small, fill=color)
            draw.text((x + card_width // 2, y + card_height // 2),
                      symbol, font=large, fill=color, anchor="mm")
            draw.text((x + card_width - 12, y + card_height - 28),
                      rank, font=small, fill=color, anchor="ra")
    image.save(ASSETS / "cards.png")


def make_chess_pieces() -> None:
    tile = 68
    image = Image.new("RGBA", (tile * 6, tile * 2), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    font = load_font(30)
    for row, fill in enumerate(["white", "black"]):
        for column, piece in enumerate(["P", "N", "B", "R", "Q", "K"]):
            x, y = column * tile, row * tile
            draw.ellipse([x + 5, y + 5, x + tile - 6, y + tile - 6],
                         fill=fill, outline="black", width=2)
            draw.text((x + tile // 2, y + tile // 2), piece, font=font,
                      fill="black" if fill == "white" else "white", anchor="mm")
    image.save(ASSETS / "chess-pieces.png")


def make_terrain() -> None:
    tile = 64
    image = Image.new("RGBA", (tile * 6, tile), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    colors = [(96, 160, 72), (64, 120, 190), (38, 92, 48),
              (130, 130, 130), (214, 190, 120), (160, 130, 90)]
    for index, color in enumerate(colors):
        draw.rectangle([index * tile, 0, (index + 1) * tile - 1, tile - 1], fill=color)
        draw.rectangle([index * tile, 0, (index + 1) * tile - 1, tile - 1],
                       outline=(40, 40, 40))
    image.save(ASSETS / "terrain.png")


def make_wizard() -> None:
    image = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.ellipse([10, 10, 54, 54], fill=(120, 80, 200), outline="black", width=2)
    draw.polygon([(32, 6), (20, 30), (44, 30)], fill=(70, 40, 140), outline="black")
    draw.text((32, 38), "W", font=load_font(22), fill="white", anchor="mm")
    image.save(ASSETS / "wizard.png")


def make_chess_position() -> None:
    back_rank = ["R", "N", "B", "Q", "K", "B", "N", "R"]
    lines: list[str] = []
    for column, piece in enumerate(back_rank):
        lines.append(f"W{piece} {chr(ord('a') + column)}1")
    for column in range(8):
        lines.append(f"WP {chr(ord('a') + column)}2")
    for column, piece in enumerate(back_rank):
        lines.append(f"B{piece} {chr(ord('a') + column)}8")
    for column in range(8):
        lines.append(f"BP {chr(ord('a') + column)}7")
    (ASSETS / "chess-start.cp").write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    ASSETS.mkdir(parents=True, exist_ok=True)
    make_cards()
    make_chess_pieces()
    make_terrain()
    make_wizard()
    make_chess_position()
    print(f"Regenerated Java assets in {ASSETS}")


if __name__ == "__main__":
    main()
