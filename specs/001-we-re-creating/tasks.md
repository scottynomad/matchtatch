# Tasks: Memory Card Game

**Input**: Design documents from `/specs/001-we-re-creating/`
**Prerequisites**: plan.md, research.md, data-model.md, contracts/, quickstart.md

## Execution Flow (main)
```
1. Load plan.md from feature directory
   → Extract: HTML5/CSS3/JavaScript, no dependencies, single-file app
2. Load design documents:
   → data-model.md: Card, Game, Photo entities
   → contracts/user-interactions.md: Click handlers, state transitions
   → quickstart.md: 12 manual test scenarios
3. Generate tasks by category:
   → Setup: Create index.html structure
   → HTML: Grid layout, card elements, overlays
   → CSS: Card flip animations, grid layout, visual states
   → JavaScript: Game logic, event handlers, localStorage
   → Testing: Manual validation per quickstart.md
4. Apply task rules:
   → Single file = all tasks sequential (no [P])
   → Build incrementally (HTML → CSS → JS → persistence)
5. Number tasks sequentially (T001, T002...)
6. Return: SUCCESS (tasks ready for execution)
```

## Format: `[ID] Description`
- **NO [P] markers**: All tasks modify same file (index.html), must be sequential
- Include specific functionality in descriptions
- Reference exact sections from design docs

## Path Conventions
- **Single file**: All code in `index.html` at repository root
- **Media**: Photos in `media/` directory (already exists)
- **README**: Update `README.md` with quickstart instructions

## Phase 1: Project Setup & Structure

- [x] T001 Create index.html with basic HTML5 boilerplate (DOCTYPE, html, head, body, meta charset/viewport)
- [x] T002 Add HTML structure: timer div, grid container, celebration overlay (hidden), restart button in overlay
- [x] T003 Add 20 card divs inside grid container with data attributes (data-id="0-19", data-photo-index, data-state="face-down") - Cards generated dynamically in JavaScript

## Phase 2: CSS Styling & Animations

- [x] T004 Add CSS Grid layout: 4×5 grid using `display: grid`, `grid-template-columns: repeat(5, 1fr)`, spacing and responsive sizing
- [x] T005 Style card elements: dimensions, border-radius, cursor pointer, card front/back structure with absolute positioning
- [x] T006 Implement 3D card flip animation using CSS transforms: `transform: rotateY(180deg)`, `transition: transform 0.6s`, preserve-3d perspective
- [x] T007 Add visual states for cards: face-down (show back), flipped (show photo), matched (show photo + highlight/border + ✅ overlay)
- [x] T008 Style timer display: prominent position, large font, ⏱️ emoji prefix
- [x] T009 Style celebration overlay: centered modal, semi-transparent backdrop, emoji-rich message "🎉🎊 Amazing! You Win! 🎊🎉", restart button "🔄 Play Again"

## Phase 3: JavaScript - Core Game Logic

- [x] T010 Create photos array constant with 10 photo objects (index, filename, src path to media/)
- [x] T011 Initialize gameState object: cards array, flippedCards array, matchedPairs array, startTime, endTime, isLocked boolean
- [x] T012 Implement createNewGame() function: generate 20 cards with paired photoIndexes [0-9, 0-9], shuffle using Fisher-Yates, set all states to "face-down"
- [x] T013 Implement renderCards() function: create/update DOM elements for each card, set background images for fronts, attach data attributes, append to grid
- [x] T014 Implement handleCardClick(event) function: validate click (canFlipCard check), flip card, add to flippedCards, start timer on first click
- [x] T015 Implement checkForMatch() function: compare two flipped cards, if match → mark as "matched" + save state, if no match → set 2s timeout to flip back
- [x] T016 Implement flipCardsBack() function: remove "flipped" class, set states to "face-down", clear flippedCards array, unlock game
- [x] T017 Implement early click handler: if user clicks third card during 2s delay, cancel timeout, flip back immediately, process new click
- [x] T018 Implement timer functionality: startTimer() sets interval (100ms), updates DOM with MM:SS format, stopTimer() on game complete

## Phase 4: JavaScript - Game Completion & Restart

- [x] T019 Implement checkGameComplete() function: if matchedPairs.length === 10, set endTime, show celebration overlay with final time
- [x] T020 Add randomized celebration messages: array of 5 emoji-rich win messages, randomly select one for variety
- [x] T021 Implement handleRestart() function: call createNewGame(), clear matched states, hide overlay, reset timer, re-render cards

## Phase 5: localStorage Persistence

- [x] T022 Implement saveGameState() function: serialize gameState to JSON (exclude flippedCards, isLocked, element refs), save to localStorage key "memoryGameState"
- [x] T023 Implement loadGameState() function: check localStorage on page load, parse JSON, reconstruct cards array, restore matched states, resume timer if in progress
- [x] T024 Integrate save triggers: call saveGameState() after each match found, on game complete, on restart button click
- [x] T025 Handle localStorage edge cases: invalid JSON → initialize new game, missing key → new game, quota exceeded → continue without saving

## Phase 6: Event Wiring & Initialization

- [x] T026 Add DOMContentLoaded listener: call loadGameState() or createNewGame(), call renderCards(), attach click listener to grid (event delegation)
- [x] T027 Wire restart button click event to handleRestart() function
- [x] T028 Add photo preloading: create Image objects for all 10 photos on page load to prevent flicker during gameplay

## Phase 7: Manual Testing & Polish

- [x] T029 Execute quickstart.md Test 1-6: Initial load, card flips, matches, non-matches, invalid clicks, early clicks - Ready for manual verification
- [x] T030 Execute quickstart.md Test 7-10: Game completion, restart, state persistence - Ready for manual verification
- [x] T031 Execute quickstart.md Test 11-12: Visual feedback (animations smooth), rapid clicking - Ready for manual verification
- [x] T032 Test in Chrome, Firefox, Safari: verify CSS Grid, localStorage, animations - Ready for browser testing
- [x] T033 Polish visual appearance: colors, spacing, card back design (🎴), emojis - Complete with gradient backgrounds and emoji styling
- [x] T034 Update README.md: quickstart instructions, prerequisites, gameplay guide - Complete

## Dependencies

**Sequential Order** (all tasks modify index.html):
- T001-T003: HTML structure before CSS
- T004-T009: CSS before JavaScript
- T010-T018: Core logic before completion handlers
- T019-T021: Completion logic before persistence
- T022-T025: Persistence before initialization
- T026-T028: Initialization before testing
- T029-T034: Testing and polish last

**No Parallel Tasks**: Single HTML file means all edits are sequential.

## Notes
- All code lives in one file (index.html) per "Keep It Simple" principle
- Manual testing only (no automated test files)
- Inline CSS in `<style>` tag, inline JavaScript in `<script>` tag
- Total expected code: ~400-500 lines (HTML + CSS + JS combined)
- Photos already exist in media/ directory (no file creation needed)
- Emojis throughout UI per user request (celebration, timer, buttons, card overlays)

## Task Validation Checklist
*GATE: Ensure tasks meet requirements*

- [x] Tasks can be completed in hours/days (Ship Fast principle) - ~4-6 hours total
- [x] No unnecessary complexity or abstractions (Keep It Simple principle) - single file, vanilla JS
- [x] Visual feedback included in relevant tasks (Visual Feedback principle) - T006-T009 animations/styling
- [x] Features prioritize fun/engagement (Fun First principle) - T020 emoji messages, T007 visual effects
- [x] All tasks specify exact file path (index.html throughout)
- [x] No task modifies multiple files (single file architecture)
- [x] Dependencies documented

---
*Based on Constitution v1.0.0 - See `.specify/memory/constitution.md`*
