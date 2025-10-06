# Research: Memory Card Game

## Overview
Research findings for implementing a vanilla JavaScript memory card game with localStorage persistence and CSS animations.

## Technology Decisions

### Decision: Vanilla JavaScript (No Framework)
**Rationale**:
- Constitution principle "Keep It Simple" mandates avoiding frameworks
- Total code size <500 lines easily achievable with vanilla JS
- No build tools = faster development (Ship Fast principle)
- Single HTML file deployment aligns with simplicity goals

**Alternatives Considered**:
- React: Rejected - adds build complexity, overkill for simple game
- Vue: Rejected - still requires tooling, violates Keep It Simple
- jQuery: Rejected - unnecessary dependency for modern browsers

### Decision: CSS Transitions for Card Flips
**Rationale**:
- Native CSS `transform: rotateY()` provides smooth 3D flip effect
- Hardware-accelerated animations ensure 60fps
- No JavaScript animation libraries needed
- `.card.flipped` class toggle is simple and declarative

**Alternatives Considered**:
- JavaScript animation libraries (GSAP, Anime.js): Rejected - adds dependency
- Canvas-based rendering: Rejected - overcomplicated for card flips
- CSS keyframe animations: Considered, but transitions simpler for toggles

### Decision: localStorage for Game State Persistence
**Rationale**:
- Built into all modern browsers, no external service needed
- Synchronous API perfect for simple state save/load
- Persists across browser sessions (meets FR-019, FR-020)
- Can serialize game state as JSON easily

**Alternatives Considered**:
- IndexedDB: Rejected - async complexity unnecessary for small state object
- SessionStorage: Rejected - clears on tab close, doesn't meet requirements
- Cookies: Rejected - 4KB limit might be tight, less ergonomic API

### Decision: CSS Grid for 4×5 Card Layout
**Rationale**:
- `display: grid; grid-template-columns: repeat(5, 1fr);` creates perfect grid
- Responsive and automatically handles spacing
- No manual positioning math required
- Native browser feature, no library needed

**Alternatives Considered**:
- Flexbox with wrapping: Considered, but Grid more semantic for 2D layout
- Absolute positioning: Rejected - manual calculations, not responsive
- Table layout: Rejected - outdated, less flexible

### Decision: Relative File Paths for Media Directory
**Rationale**:
- `<img src="media/photo.jpg">` works for local file hosting
- No server configuration or API endpoints needed
- Keeps project portable and self-contained
- Aligns with "local hosting" requirement

**Alternatives Considered**:
- Data URLs (Base64 embed): Rejected - bloats HTML, harder to update photos
- External image hosting: Rejected - requires internet, violates offline constraint
- Dynamic import via fetch(): Rejected - adds async complexity

## Implementation Patterns

### Game State Management
**Pattern**: Single JavaScript object holds all state
```javascript
const gameState = {
  cards: [],           // Array of 20 card objects
  flippedCards: [],    // Currently visible (max 2)
  matchedPairs: [],    // IDs of matched cards
  startTime: null,     // Timer start timestamp
  isLocked: false      // Prevent clicks during animations
};
```

**Rationale**: Simple, easy to serialize to localStorage, no state library needed.

### Card Flip Animation Timing
**Pattern**: Use CSS `transition: transform 0.6s` for flip effect
- Card flip: 0.6 seconds (smooth but not slow)
- Mismatch flip-back delay: 2 seconds (per clarification)
- Match confirmation: Immediate (no artificial delay)

**Rationale**: Balances visual appeal (Fun First) with responsiveness (Visual Feedback).

### Event Handling
**Pattern**: Single click listener on grid container with event delegation
```javascript
grid.addEventListener('click', (e) => {
  const card = e.target.closest('.card');
  if (!card || gameState.isLocked) return;
  // Handle card click
});
```

**Rationale**: Fewer event listeners (20 cards, 1 listener), easy to manage lock state.

## Browser Compatibility Notes
- **Target**: Chrome, Firefox, Safari (modern versions only)
- **CSS Grid**: Supported in all modern browsers (2017+)
- **localStorage**: Universal support
- **ES6+ features**: Modules not needed (single inline script), use const/let/arrow functions

## Performance Considerations
- **Image Loading**: Preload all 10 photos on page load to prevent flicker
- **Animation Performance**: Use `transform` and `opacity` (GPU-accelerated)
- **State Persistence**: Save to localStorage only on significant events (match, restart), not every click

## Security Notes
- **XSS Risk**: None (no user input, no dynamic HTML from external sources)
- **localStorage Size**: Max ~10MB, our state object <1KB (well within limits)
- **Photo Privacy**: Local files only, no external transmission

## Accessibility Considerations
**Deferred**: Per constitution, production-grade accessibility (ARIA labels, keyboard nav) is out of scope for this kids demo. Basic mouse/touch interaction only.

## Testing Strategy
- **Manual Testing**: Open in browser, play through game scenarios
- **Quickstart Validation**: Follow README steps to verify working state
- **No Automated Tests**: Per constitution, manual testing sufficient

## Risks & Mitigations
| Risk | Mitigation |
|------|------------|
| Photos too large (slow loading) | Accept minor delay; optimization out of scope |
| localStorage quota exceeded | Unlikely (<1KB state), no mitigation needed |
| Browser compatibility issues | Test in Chrome/Firefox/Safari only |
| Card grid doesn't fit screen | Use max-width and responsive grid, accept scrolling if needed |

## Open Questions
**None** - All technical unknowns resolved. Ready for Phase 1 design.
