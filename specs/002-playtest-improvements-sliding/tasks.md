# Tasks: Playtest Improvements

**Input**: Spec from `/specs/002-playtest-improvements-sliding/spec.md`
**Prerequisites**: Existing game from feature 001 (index.html at 548 lines)

## Execution Flow
```
1. Load spec.md: 7 playtest improvements to enhance existing game
2. Identify components:
   → MatchedCardsArea (bottom display zone)
   → BestScore tracking (localStorage)
   → MotivationalMessage system
   → ConfettiParticle animation
   → FireworksEffect celebration
3. Generate tasks by improvement:
   → Improvement 1-2: Matched cards sliding & pulsing (HTML + CSS + JS)
   → Improvement 3: Best time tracking (localStorage + display)
   → Improvement 4-5: Motivational messages (JS + CSS)
   → Improvement 6-7: Confetti & fireworks animations (CSS + JS)
4. Order: HTML structure → CSS animations → JS logic → integration → testing
5. All tasks modify single file (index.html) - sequential execution only
```

## Format: `[ID] Description`
- **NO [P] markers**: All tasks modify index.html, must be sequential
- Specific functionality and file location in each description

## Path Conventions
- **Single file**: All changes to `index.html` at repository root
- **Backup**: Original game preserved in git history (feature 001 branch)

## Phase 1: HTML Structure for New Components

- [x] T001 Add matched-cards-area container div at bottom of body (fixed position, hidden initially, will hold scaled-down matched cards)
- [x] T002 Add best-time display div above grid-container showing "🏆 Best Time: MM:SS" (hidden if no best time exists)
- [x] T003 Add motivational-message div (centered, positioned above grid, hidden initially, will show progress messages)
- [x] T004 Update celebration overlay h1 to include id for dynamic message updates (for new record announcements)

## Phase 2: CSS Styling for New Components & Animations

- [x] T005 Style matched-cards-area: fixed bottom position, full width, flexbox row layout, gap between cards, padding, background with slight transparency
- [x] T006 Add .matched-card-small class: scale transform 0.5, width/height 70px (50% of 140px), maintain flip animation compatibility
- [x] T007 Create slide-to-bottom keyframe animation: translateY from original position to bottom area, 0.6s duration, ease-out timing
- [x] T008 Style best-time display: large font (1.5em), gold color, positioned above grid, 🏆 emoji prefix styling
- [x] T009 Style motivational-message: centered text, large font (2em), bright color, fade-in/fade-out animations (fadeInMessage, fadeOutMessage keyframes)
- [x] T010 Create confetti CSS classes: .confetti particle base style, random rotations, fall animation with translateY + rotate transforms
- [x] T011 Create fireworks CSS: keyframes for burst patterns (@keyframes fireworkBurst), multiple colored variants (red, blue, gold, purple)
- [x] T012 Add pulse-cards keyframe animation: scale 1.05 → 1.0, opacity 0.8 → 1.0, for bottom cards when wrong match

## Phase 3: JavaScript - Best Time Tracking

- [x] T013 Add loadBestTime() function: check localStorage for "memoryGameBestTime", parse int, display in best-time div if exists, return value or null
- [x] T014 Add saveBestTime(timeMs) function: save to localStorage "memoryGameBestTime", update best-time div display
- [x] T015 Modify checkGameComplete() function: after setting endTime, compare elapsed time to best time, if faster call saveBestTime(), show "🎉 NEW RECORD! 🎉" message
- [x] T016 Call loadBestTime() in DOMContentLoaded: display existing record on page load

## Phase 4: JavaScript - Matched Cards Sliding

- [x] T017 Create slideCardToBottom(card) function: calculate card's current position, create clone with .matched-card-small class, append to matched-cards-area, animate slide-to-bottom, hide original card in grid
- [x] T018 Modify checkForMatch() success path: after marking cards as matched, call slideCardToBottom() for both cards, show matched-cards-area if hidden
- [x] T019 Add pulseBottomCards() function: add pulse-cards animation class to all cards in matched-cards-area, remove class after animation (0.5s)
- [x] T020 Modify flipCardsBack() function: call pulseBottomCards() before flipping mismatched cards back

## Phase 5: JavaScript - Motivational Messages

- [x] T021 Create MOTIVATIONAL_MESSAGES object: map 0→"🎯 Let's match them all!", 3→"🌟 Great start! Keep going!", 6→"🔥 You're on fire!", 9→"💪 Almost there! One more!"
- [x] T022 Add showMotivationalMessage(matchCount) function: check if matchCount in MOTIVATIONAL_MESSAGES keys, get message, set motivational-message div text, add fadeInMessage class, setTimeout to add fadeOutMessage after 2.5s
- [x] T023 Modify checkForMatch() success path: after adding to matchedPairs, call showMotivationalMessage(gameState.matchedPairs.length)
- [x] T024 Call showMotivationalMessage(0) in createNewGame(): show initial "Let's match them all!" message on new game start

## Phase 6: JavaScript - Confetti Animation

- [x] T025 Create createConfetti(x, y, count) function: generate 15-20 confetti particle divs, position at x/y coords, add random colors/emojis (🎉🎊⭐✨), random rotation, append to body
- [x] T026 Add CSS fall animation to confetti particles: translateY(100vh) + random rotation, 1.5s duration, remove from DOM after animation complete
- [x] T027 Modify checkForMatch() success path: get matched card positions, calculate center point, call createConfetti(centerX, centerY, 18)
- [x] T028 Add removeConfetti() helper: select all .confetti elements, remove after 2 seconds (cleanup)

## Phase 7: JavaScript - Fireworks & Win Celebration

- [x] T029 Create createFireworks() function: generate 8-10 firework burst divs, position randomly around celebration overlay, add burst animation classes, cycle through colors
- [x] T030 Add CSS keyframes for firework bursts: scale + opacity animations, stagger timing for continuous effect
- [x] T031 Modify checkGameComplete() function: call createFireworks() before showing overlay, add "👏 👏 👏" clapping emojis to celebration message
- [x] T032 Modify handleRestart() function: remove all firework elements from DOM before hiding overlay, clear matched-cards-area

## Phase 8: Integration & Bug Fixes

- [x] T033 Ensure matched cards in bottom area are not clickable: add pointer-events: none to .matched-card-small class
- [x] T034 Fix card ID tracking: when creating clones for bottom area, ensure original cards in grid are properly hidden/removed from interaction
- [x] T035 Test localStorage edge cases: verify bestTime saves/loads correctly, handle NaN or invalid values, reset if needed
- [x] T036 Optimize animation performance: use will-change CSS property for confetti/fireworks, ensure 60fps on modest hardware
- [x] T037 Add fadeOut animations cleanup: ensure motivational messages remove fadeInMessage class before adding fadeOutMessage

## Phase 9: Visual Polish & Testing

- [x] T038 Adjust matched-cards-area spacing: ensure 10 matched pairs (20 cards at 50% size) fit comfortably at bottom on standard screens
- [x] T039 Polish motivational message styling: add text shadow for readability, ensure emoji render clearly, test various screen sizes
- [x] T040 Test confetti timing: verify particles don't overlap with next match animation, adjust count/duration if needed
- [x] T041 Test fireworks visual impact: ensure colorful enough to feel celebratory but not overwhelming, adjust opacity/count
- [x] T042 Verify best time updates correctly: test multiple game completions, ensure fastest time persists, new record message appears
- [x] T043 Test pulse animation on wrong match: verify bottom cards pulse noticeably but not distractingly
- [x] T044 Manual playtest all 7 improvements: verify each acceptance scenario from spec.md, ensure existing game functionality intact

## Dependencies

**Sequential Order** (all tasks modify index.html):
- T001-T004: HTML structure before CSS
- T005-T012: CSS before JavaScript
- T013-T016: Best time tracking foundation before integration
- T017-T020: Card sliding before motivational messages (depends on match detection)
- T021-T024: Motivational messages independent of sliding
- T025-T028: Confetti independent but integrates with match detection
- T029-T032: Fireworks depends on game completion flow
- T033-T037: Integration fixes after core features
- T038-T044: Polish and testing last

**No Parallel Tasks**: Single HTML file means all edits are sequential.

## Notes
- All code additions to existing index.html (~548 lines currently)
- Expected addition: +150-200 lines (CSS animations + JS functions)
- Target final size: ~700-750 lines total
- Manual testing only (no automated test files per constitution)
- Emojis throughout: 🏆 🎯 🌟 🔥 💪 🎉 🎊 ⭐ ✨ 👏 🎆 🎇
- Must preserve all existing functionality from feature 001

## Task Validation Checklist

- [x] Tasks can be completed in hours/days (Ship Fast) - ~3-4 hours total
- [x] No unnecessary complexity (Keep It Simple) - CSS-only animations, vanilla JS
- [x] Visual feedback in relevant tasks (Visual Feedback) - All 7 improvements are visual
- [x] Features prioritize fun/engagement (Fun First) - Confetti, fireworks, motivational emojis
- [x] All tasks specify exact file path (index.html throughout)
- [x] Dependencies documented
- [x] Builds on existing feature 001 without breaking changes

---
*Based on Constitution v1.0.0 - See `.specify/memory/constitution.md`*
