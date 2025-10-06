# Quickstart: Memory Card Game

## Setup

### Prerequisites
- Modern web browser (Chrome, Firefox, or Safari)
- No installation or build tools needed

### Launch Game
1. Open file explorer/Finder
2. Navigate to project root directory
3. Double-click `index.html`
4. Game opens in default browser

**Alternative**: Drag `index.html` onto browser window

## Manual Testing Checklist

### Test 1: Initial Load (New Game)
**Steps**:
1. Open `index.html` in browser
2. Clear localStorage: Open DevTools → Application → Local Storage → Delete `memoryGameState`
3. Refresh page

**Expected**:
- [ ] See 4×5 grid of 20 face-down cards (all showing back design)
- [ ] Timer displays "0:00"
- [ ] No celebration overlay visible
- [ ] Cards arranged in neat grid

### Test 2: First Card Flip
**Steps**:
1. Click any face-down card

**Expected**:
- [ ] Card flips over smoothly (3D rotation animation, ~0.6s)
- [ ] Photo becomes visible on card front
- [ ] Timer starts counting up (updates every second)
- [ ] Card stays face-up

### Test 3: Second Card Flip (No Match)
**Steps**:
1. Flip one card (photo A)
2. Click a different card with different photo (photo B)

**Expected**:
- [ ] Second card flips over showing photo
- [ ] Both cards visible for 2 seconds
- [ ] After 2 seconds, both cards flip back face-down automatically
- [ ] Timer continues running

### Test 4: Second Card Flip (Match Found)
**Steps**:
1. Flip one card (remember its photo)
2. Click the other card with the same photo

**Expected**:
- [ ] Second card flips over
- [ ] Both matching cards stay face-up permanently
- [ ] Cards get visual indication of match (highlight/border/different styling)
- [ ] Cards no longer clickable
- [ ] Timer continues running

### Test 5: Click During 2-Second Delay
**Steps**:
1. Flip two non-matching cards
2. Immediately (before 2s delay ends) click a third face-down card

**Expected**:
- [ ] First two cards flip back face-down immediately (no waiting)
- [ ] Third card flips over and stays visible
- [ ] Timer continues
- [ ] Game remains responsive

### Test 6: Invalid Clicks (Should Do Nothing)
**Steps**:
Try clicking:
1. A card already flipped (face-up)
2. A card already matched (permanently face-up)
3. The same card twice quickly

**Expected**:
- [ ] Nothing happens (clicks ignored)
- [ ] No errors in browser console
- [ ] Game state unchanged

### Test 7: Complete Game
**Steps**:
1. Play game until all 10 pairs are matched

**Expected**:
- [ ] When last pair matched, celebration overlay appears
- [ ] Overlay shows "🎉🎊 Amazing! You Win! 🎊🎉" or similar emoji-rich message
- [ ] Final time displayed with emoji (e.g., "⏱️ Time: 01:23")
- [ ] "🔄 Play Again" button visible with emoji
- [ ] All 20 cards remain face-up showing photos

### Test 8: Restart Game
**Steps**:
1. Complete a game (see celebration overlay)
2. Click "Play Again" button

**Expected**:
- [ ] Celebration overlay disappears
- [ ] All cards flip back to face-down
- [ ] Cards are reshuffled (different positions than before)
- [ ] Timer resets to "0:00"
- [ ] Game ready to play again

### Test 9: State Persistence (Page Refresh)
**Steps**:
1. Start new game, match 2-3 pairs (don't complete)
2. Note which cards are matched
3. Note the current timer value
4. Refresh the page (F5 or Cmd+R)

**Expected**:
- [ ] Game resumes with same matched pairs visible
- [ ] Unmatched cards back to face-down
- [ ] Timer continues from saved time (approximately)
- [ ] Can continue playing from where you left off
- [ ] Same card shuffle maintained (photo positions unchanged)

### Test 10: Completed Game Persistence
**Steps**:
1. Complete a full game (celebration overlay showing)
2. Refresh the page

**Expected**:
- [ ] Celebration overlay reappears on load
- [ ] All cards shown as matched
- [ ] Final time displayed
- [ ] "Play Again" button available

### Test 11: Visual Feedback
**Steps**:
Play through a full game, observing:

**Expected**:
- [ ] Card flip animations are smooth (no jank)
- [ ] Matched cards visually distinct from unmatched
- [ ] Timer updates visible and smooth
- [ ] Hover effects on cards (if implemented)
- [ ] Celebration appears immediately when last pair matched

### Test 12: Edge Case - Rapid Clicking
**Steps**:
1. Click multiple cards rapidly in succession

**Expected**:
- [ ] Only first two valid clicks register
- [ ] Additional clicks during 2s delay ignored or handled per contract
- [ ] No visual glitches or stuck states
- [ ] Game remains playable

## Performance Checks

### Animation Smoothness
- [ ] Card flips run at ~60fps (smooth, no stutter)
- [ ] Timer updates don't cause visual jank
- [ ] Multiple animations can run simultaneously

### Load Time
- [ ] Page loads in <2 seconds (even with 10 large photos)
- [ ] Photos visible immediately when cards flip (preloaded)

## Browser Compatibility

Test in each target browser:
- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)

## Known Limitations (Acceptable)
Per constitution, these are **not** issues to fix:
- Photos may be large and take time to load initially
- No keyboard navigation (mouse/touch only)
- No screen reader support
- No mobile responsiveness tuning (desktop only)
- No error messages if photos missing (broken image icon acceptable)
- localStorage quota exceeded (unlikely, but no handling if it occurs)

## Success Criteria
Game is ready to ship if:
- [ ] All 12 manual tests pass
- [ ] No JavaScript errors in console during normal gameplay
- [ ] Game is fun to play (subjective, but ask a kid!)
- [ ] Timer works and displays correctly
- [ ] State persistence works across refreshes

## Troubleshooting

### Cards not showing photos
- Check media/ directory contains all 10 .jpg files
- Verify file paths in code match actual filenames

### Timer not starting
- Ensure click is registering (check console for errors)
- Verify startTime is being set on first card flip

### localStorage not persisting
- Check browser allows localStorage (not in private/incognito mode)
- Open DevTools → Application → Local Storage to inspect stored data

### Cards stuck in flipped state
- Refresh page to reset (state should restore correctly)
- Check for JavaScript errors blocking state transitions

## Development Tips

### View Game State
Open browser DevTools console and type:
```javascript
JSON.parse(localStorage.getItem("memoryGameState"))
```
Shows current saved state.

### Reset Game Completely
```javascript
localStorage.removeItem("memoryGameState");
location.reload();
```

### Force Complete State (Testing)
Manually edit localStorage to set all pairs as matched, then refresh to trigger celebration overlay.
