# Data Model: Memory Card Game

## Overview
Simple in-memory JavaScript data structures. No database, no ORM. State serializes to localStorage as JSON.

## Entities

### Card
Represents a single game card in the 4×5 grid.

**Fields**:
- `id`: Number (0-19) - Unique identifier and grid position
- `photoIndex`: Number (0-9) - Index into photos array (determines which image)
- `state`: String enum - Current card state
  - `"face-down"` - Initial state, back showing
  - `"flipped"` - Currently face-up (showing photo)
  - `"matched"` - Permanently face-up (pair found)
- `element`: DOM Reference - The HTML `.card` div element

**Validation Rules**:
- `id` must be 0-19 (exactly 20 cards)
- `photoIndex` must be 0-9 (10 unique photos)
- Each `photoIndex` appears exactly twice (10 pairs)
- `state` transitions: `face-down` → `flipped` → `matched` or `face-down`

**State Transitions**:
```
face-down ──(click)──> flipped
flipped ──(match detected)──> matched [TERMINAL]
flipped ──(no match, 2s delay)──> face-down
flipped ──(new card clicked during delay)──> face-down [immediate]
```

**Invariants**:
- Max 2 cards in `flipped` state at any time (non-matched)
- Cards in `matched` state cannot transition back
- Clicking card already `flipped` or `matched` has no effect

### Game
Represents current play session state.

**Fields**:
- `cards`: Array<Card> - All 20 card objects in shuffled order
- `flippedCards`: Array<Card> - Currently visible cards (length 0-2)
- `matchedPairs`: Array<Number> - photoIndex values of matched pairs (length 0-10)
- `startTime`: Number | null - Timestamp (ms) when first card flipped, null before start
- `endTime`: Number | null - Timestamp (ms) when last pair matched, null during play
- `isLocked`: Boolean - True during flip-back animation (prevent clicks)

**Validation Rules**:
- `cards.length` always 20
- `flippedCards.length` ≤ 2
- `matchedPairs.length` ≤ 10
- `matchedPairs` contains unique values (0-9)
- `isLocked` true only during 2-second mismatch delay or immediate flip-back
- `startTime` < `endTime` when both non-null

**Derived Values**:
- `elapsedTime`: Number - `(endTime || Date.now()) - startTime` (milliseconds)
- `isComplete`: Boolean - `matchedPairs.length === 10`
- `matchedCount`: Number - `matchedPairs.length`

### Photo
Reference to image file in media directory.

**Fields**:
- `index`: Number (0-9) - Photo identifier
- `filename`: String - Actual filename in media/ directory
- `src`: String - Relative path (`"media/{filename}"`)

**Static List** (hardcoded in JS):
```javascript
const photos = [
  { index: 0, filename: "PXL_20251006_012805987.jpg", src: "media/PXL_20251006_012805987.jpg" },
  { index: 1, filename: "PXL_20251006_012832685.jpg", src: "media/PXL_20251006_012832685.jpg" },
  { index: 2, filename: "PXL_20251006_012911401.jpg", src: "media/PXL_20251006_012911401.jpg" },
  { index: 3, filename: "PXL_20251006_012926645.jpg", src: "media/PXL_20251006_012926645.jpg" },
  { index: 4, filename: "PXL_20251006_013024904.jpg", src: "media/PXL_20251006_013024904.jpg" },
  { index: 5, filename: "PXL_20251006_013127007.jpg", src: "media/PXL_20251006_013127007.jpg" },
  { index: 6, filename: "PXL_20251006_013154729.jpg", src: "media/PXL_20251006_013154729.jpg" },
  { index: 7, filename: "PXL_20251006_013222447.jpg", src: "media/PXL_20251006_013222447.jpg" },
  { index: 8, filename: "PXL_20251006_013234429.jpg", src: "media/PXL_20251006_013234429.jpg" },
  { index: 9, filename: "PXL_20251006_013335597.jpg", src: "media/PXL_20251006_013335597.jpg" }
];
```

## Relationships

### Card ↔ Photo
- **Type**: Many-to-One
- **Cardinality**: 2 cards per photo (each photoIndex appears twice)
- **Implementation**: `card.photoIndex` references `photo.index`

### Game ↔ Card
- **Type**: One-to-Many
- **Cardinality**: 1 game has exactly 20 cards
- **Implementation**: `gameState.cards` array contains all Card objects

### Game ↔ Flipped Cards
- **Type**: One-to-Few
- **Cardinality**: 1 game has 0-2 flipped cards at any moment
- **Implementation**: `gameState.flippedCards` array (subset of `gameState.cards`)

## Persistence Strategy

### localStorage Schema
**Key**: `"memoryGameState"`

**Value** (JSON):
```json
{
  "cards": [
    {"id": 0, "photoIndex": 3, "state": "matched"},
    {"id": 1, "photoIndex": 7, "state": "face-down"},
    ...
  ],
  "matchedPairs": [3, 7, 1],
  "startTime": 1696521234567,
  "endTime": null
}
```

**Notes**:
- `flippedCards` NOT persisted (reset to `[]` on reload)
- `isLocked` NOT persisted (reset to `false` on reload)
- DOM `element` references NOT serialized (rebuilt on page load)
- `cards` array order preserved (maintains shuffle)

### Persistence Triggers
- **Save**: After match found, on restart button click
- **Load**: On page load (DOMContentLoaded)
- **Clear**: On restart button click (save new shuffled state)

## Initialization Logic

### New Game
1. Create 20 cards: `[0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9]` photoIndex values
2. Shuffle array using Fisher-Yates algorithm
3. Assign sequential IDs 0-19 (determines grid position)
4. Set all states to `"face-down"`
5. Initialize `gameState`: empty flipped/matched arrays, null startTime, unlocked
6. Save to localStorage
7. Render to DOM

### Resume Game (Page Reload)
1. Load JSON from localStorage
2. Reconstruct `cards` array with saved photoIndex/state
3. Rebuild DOM elements for each card
4. Restore matched pairs to `"matched"` state (visual)
5. Reset `flippedCards` to empty, `isLocked` to false
6. Resume timer from saved `startTime`

## Validation Functions

### `isValidCard(card)`
- Has id (0-19), photoIndex (0-9), state (valid enum)
- Returns boolean

### `isValidGameState(state)`
- cards.length === 20
- All photoIndex 0-9 appear exactly twice
- flippedCards.length ≤ 2
- matchedPairs contains unique values
- Returns boolean

### `canFlipCard(card, gameState)`
- Card state is `"face-down"`
- `gameState.isLocked` is false
- `gameState.flippedCards.length` < 2
- Returns boolean

## Sample Data

### Initial Shuffled Cards (Example)
```javascript
[
  {id: 0, photoIndex: 4, state: "face-down"},
  {id: 1, photoIndex: 1, state: "face-down"},
  {id: 2, photoIndex: 7, state: "face-down"},
  {id: 3, photoIndex: 4, state: "face-down"}, // Pair with id:0
  {id: 4, photoIndex: 9, state: "face-down"},
  // ... 15 more cards
]
```

### Mid-Game State
```javascript
{
  cards: [ /* 20 cards, some matched */ ],
  flippedCards: [],
  matchedPairs: [4, 7, 1],  // 3 pairs found
  startTime: 1696521234567,
  endTime: null,
  isLocked: false
}
```

### Completed Game
```javascript
{
  cards: [ /* all 20 cards in "matched" state */ ],
  flippedCards: [],
  matchedPairs: [0,1,2,3,4,5,6,7,8,9],  // All 10 pairs
  startTime: 1696521234567,
  endTime: 1696521456789,
  isLocked: false
}
```

## UI Text & Emoji Guidelines

### Celebration Messages
Use emoji-rich messages for excitement (Fun First principle):
- **Win message**: "🎉🎊 Amazing! You Win! 🎊🎉"
- **Timer display**: "⏱️ Time: MM:SS"
- **Restart button**: "🔄 Play Again"
- **Alternative win messages** (randomize for variety):
  - "🌟 Fantastic! You're a Memory Champion! 🌟"
  - "🎯 Perfect Match! You Did It! 🎯"
  - "🏆 Winner Winner! Great Job! 🏆"
  - "✨ Brilliant! All Pairs Found! ✨"

### Card States Visual Indicators
- **Matched pairs**: Could use ✅ or ✨ overlay on cards
- **Timer running**: Use ⏱️ emoji prefix
- **Card back design**: Could incorporate 🎴 or 🃏 imagery
