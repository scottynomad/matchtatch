# User Interaction Contract

## Overview
Defines expected behavior for all user interactions in the memory card game. No network APIs - this is a client-side contract for event handling.

## Contract: Card Click

### Trigger
User clicks on a card element in the grid.

### Preconditions
- Card exists in DOM with class `.card`
- Game is not in locked state

### Input
- Click event on `.card` element
- Card has attributes: `data-id`, `data-photo-index`, `data-state`

### Behavior

#### Scenario 1: Valid Flip (First Card)
**Given**: Card state is `"face-down"` AND `flippedCards.length === 0`
**When**: User clicks card
**Then**:
- Add `"flipped"` class to card element
- Update card state to `"flipped"`
- Add card to `flippedCards` array
- If `startTime` is null, set to `Date.now()`
- Visual: Card rotates 180° showing photo (0.6s animation)

#### Scenario 2: Valid Flip (Second Card, Match)
**Given**: Card state is `"face-down"` AND `flippedCards.length === 1` AND click card has different ID but same photoIndex as flipped card
**When**: User clicks card
**Then**:
- Add `"flipped"` class to card element
- Wait 0.6s for flip animation
- Add `"matched"` class to both cards
- Update both card states to `"matched"`
- Add photoIndex to `matchedPairs` array
- Clear `flippedCards` array
- Save state to localStorage
- Visual: Both cards stay face-up, add green border or highlight
- If `matchedPairs.length === 10`, trigger game completion

#### Scenario 3: Valid Flip (Second Card, No Match)
**Given**: Card state is `"face-down"` AND `flippedCards.length === 1` AND click card has different photoIndex than flipped card
**When**: User clicks card
**Then**:
- Add `"flipped"` class to card element
- Set `isLocked = true`
- Wait 2 seconds (mismatch delay)
- Remove `"flipped"` class from both cards
- Update both card states to `"face-down"`
- Clear `flippedCards` array
- Set `isLocked = false`
- Visual: Both cards flip back after 2s

#### Scenario 4: Invalid Click (Card Already Flipped)
**Given**: Card state is `"flipped"` OR `"matched"`
**When**: User clicks card
**Then**:
- Do nothing (click ignored)
- No visual feedback

#### Scenario 5: Invalid Click (Game Locked)
**Given**: `isLocked === true` (during 2-second delay)
**When**: User clicks any card
**Then**:
- Do nothing (click ignored)
- No state changes

#### Scenario 6: Early Click During Mismatch Delay
**Given**: Two cards flipped (no match), 2-second timer active AND user clicks third card before delay ends
**When**: User clicks new face-down card
**Then**:
- Cancel 2-second timer immediately
- Flip back the two mismatched cards (no delay)
- Remove `"flipped"` class from previous two cards
- Update previous card states to `"face-down"`
- Clear `flippedCards` array
- Set `isLocked = false`
- Flip the newly clicked card (Scenario 1 behavior)

### Postconditions
- `flippedCards.length` ≤ 2
- Card states reflect visual presentation
- Timer running if any cards have been flipped
- State consistency maintained

## Contract: Restart Button Click

### Trigger
User clicks "Play Again" button in celebration overlay.

### Preconditions
- Game is complete (`matchedPairs.length === 10`)
- Celebration overlay is visible

### Input
- Click event on `.restart-button` element

### Behavior
**When**: User clicks restart button
**Then**:
- Create new shuffled cards array
- Reset all card states to `"face-down"`
- Clear `matchedPairs`, `flippedCards` arrays
- Set `startTime = null`, `endTime = null`
- Set `isLocked = false`
- Save new state to localStorage
- Hide celebration overlay
- Remove `"flipped"` and `"matched"` classes from all cards
- Re-render grid with new shuffle
- Visual: Cards reset to face-down, timer resets to 0:00

### Postconditions
- Fresh game state ready
- All cards face-down
- Timer not started (waits for first click)

## Contract: Page Load

### Trigger
Browser loads `index.html` (initial load or refresh).

### Preconditions
- None (can be first visit or returning)

### Input
- DOMContentLoaded event

### Behavior

#### Scenario 1: First Visit (No Saved State)
**Given**: `localStorage.getItem("memoryGameState")` returns null
**When**: Page loads
**Then**:
- Initialize new game (Scenario from Restart Button)
- Render 20 cards in 4×5 grid, all face-down
- Display timer at 0:00
- No celebration overlay

#### Scenario 2: Resume Game (Saved State Exists)
**Given**: Valid game state in localStorage
**When**: Page loads
**Then**:
- Parse JSON from localStorage
- Reconstruct cards array with saved photoIndex, state
- Render cards in grid (matched cards show photos + "matched" class)
- Reset `flippedCards = []`, `isLocked = false` (don't restore mid-flip state)
- Resume timer from `startTime` (if not null)
- If game was complete (`matchedPairs.length === 10`), show celebration overlay

### Postconditions
- DOM matches game state
- Timer running if game in progress
- Game playable

## Contract: Timer Update

### Trigger
Game is in progress (startTime not null, endTime null).

### Preconditions
- At least one card has been flipped
- Game not complete

### Behavior
**Every 100ms** (via `setInterval`):
- Calculate `elapsed = Date.now() - startTime`
- Format as `MM:SS` (e.g., "01:23")
- Update `.timer` element text content
- Continue until game complete

**When game completes**:
- Stop timer updates
- Set `endTime = Date.now()`
- Calculate final time
- Display in celebration overlay

## Contract: Game Completion

### Trigger
`matchedPairs.length` reaches 10 (all pairs found).

### Preconditions
- Last pair just matched

### Behavior
**When**: 10th pair matched
**Then**:
- Set `endTime = Date.now()`
- Calculate total time: `(endTime - startTime) / 1000` seconds
- Format as "MM:SS"
- Show celebration overlay with:
  - "🎉🎊 Amazing! You Win! 🎊🎉" message
  - "⏱️ Time: MM:SS" display
  - "🔄 Play Again" button
- Save final state to localStorage

### Postconditions
- Game no longer interactive (clicks ignored)
- Restart button available

## Validation Rules

### Card Click Validation
```javascript
function canFlipCard(card, gameState) {
  return card.state === "face-down" &&
         !gameState.isLocked &&
         gameState.flippedCards.length < 2;
}
```

### Match Detection
```javascript
function isMatch(card1, card2) {
  return card1.id !== card2.id &&
         card1.photoIndex === card2.photoIndex;
}
```

### State Persistence
Only save to localStorage when:
- Match found (incremental save)
- Game completed
- Restart clicked (new game)

Do NOT save on every click (performance).

## Error Handling

### Invalid localStorage Data
**If**: JSON parse fails or data structure invalid
**Then**: Treat as first visit, initialize new game

### Missing Photo Files
**If**: `<img>` fails to load photo from media/
**Then**: Accept broken image icon, continue game (per constitution, no error handling infrastructure)

### Browser Compatibility
**If**: localStorage not available (very old browser)
**Then**: Game works but state doesn't persist across refreshes
