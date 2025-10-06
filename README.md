# 🎴 Memory Card Game

A fun and colorful memory matching game built for kids! Match all 10 pairs of photo cards as fast as you can.

## ✨ Features

- 🎯 4×5 grid with 20 cards (10 pairs)
- 🎴 Beautiful 3D card flip animations
- ⏱️ Timer to track your speed
- 💾 Auto-save progress (survives page refresh!)
- 🎉 Celebration overlay with randomized win messages
- 🔄 Quick restart to play again

## 🚀 How to Play

### Prerequisites
- Modern web browser (Chrome, Firefox, or Safari)
- No installation or build tools needed!

### Launch Game
1. Open your file explorer/Finder
2. Navigate to the project directory
3. Double-click `index.html`
4. Game opens in your default browser

**Alternative**: Drag `index.html` onto a browser window

### Gameplay
1. Click any face-down card to flip it over
2. Click a second card to find its match
3. If the photos match, both cards stay face-up ✅
4. If they don't match, they flip back after 2 seconds
5. Find all 10 pairs as fast as you can!
6. Your progress is automatically saved 💾
7. Click "🔄 Play Again" to start a new game

## 🎮 Game Rules

- Timer starts when you flip your first card
- You can only flip 2 cards at a time
- Matched pairs stay face-up permanently
- Clicking a third card during the 2-second delay will immediately flip back the previous two cards
- Game state persists across page refreshes - you can continue where you left off!
- All cards are shuffled randomly each new game

## 🎨 Technical Details

- **Single-file application**: All HTML, CSS, and JavaScript in one file
- **Vanilla JavaScript**: No frameworks or dependencies
- **localStorage persistence**: Your progress is saved automatically
- **Responsive design**: CSS Grid layout adapts to screen size
- **Hardware-accelerated animations**: Smooth 60fps card flips using CSS transforms

## 📸 Photo Credits

The game uses 10 personal photos from the `media/` directory. To customize with your own photos:
1. Replace the 10 `.jpg` files in the `media/` folder
2. Update the filenames in `index.html` (lines 195-204) to match your new files
3. Refresh the browser and play with your custom photos!

## 🎯 Tips for Best Performance

- Make sure all photo files exist in the `media/` directory
- Photos load faster if they're optimized (recommended: <1MB each)
- Clear your browser's localStorage to start completely fresh: DevTools → Application → Local Storage → Delete `memoryGameState`

## 🐛 Troubleshooting

**Cards not showing photos?**
- Check that the `media/` directory contains all 10 photo files
- Verify filenames match exactly (case-sensitive)

**Timer not starting?**
- Make sure JavaScript is enabled in your browser
- Check browser console for any errors (F12 → Console tab)

**Game state not saving?**
- Ensure you're not in private/incognito mode
- Check that localStorage is enabled in browser settings

## 🏆 Have Fun!

Enjoy the game and see how fast you can match all the pairs! 🎉

---

Built with ❤️ using vanilla HTML, CSS, and JavaScript
