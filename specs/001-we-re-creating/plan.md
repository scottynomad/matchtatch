
# Implementation Plan: Memory Card Game

**Branch**: `001-we-re-creating` | **Date**: 2025-10-05 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/Users/scott/Development/Penny/match/specs/001-we-re-creating/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from file system structure or context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Fill the Constitution Check section based on the content of the constitution document.
4. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
5. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
6. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file (e.g., `CLAUDE.md` for Claude Code, `.github/copilot-instructions.md` for GitHub Copilot, `GEMINI.md` for Gemini CLI, `QWEN.md` for Qwen Code, or `AGENTS.md` for all other agents).
7. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
8. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
9. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
Build a web-based memory card matching game with a 4×5 grid (10 pairs, 20 cards total) using photos from the media directory. Players flip cards to find matches, with animations and timer tracking. Game state persists across page refreshes. Designed for kids with focus on visual feedback and simplicity.

## Technical Context
**Language/Version**: HTML5/CSS3/JavaScript (vanilla ES6+)
**Primary Dependencies**: None (vanilla JS, no frameworks per constitution)
**Storage**: localStorage (for game state persistence)
**Testing**: Manual testing (TDD not required per constitution)
**Target Platform**: Modern web browsers (Chrome, Firefox, Safari)
**Project Type**: Single-page web application
**Performance Goals**: Smooth 60fps animations, <100ms click response
**Constraints**: Must work offline, local hosting only (no backend)
**Scale/Scope**: Single-player, 10 photos, 20 cards, <500 lines of code total

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**I. Fun First**
- [x] Does this feature create joy or spark curiosity for kids? ✓ Memory game with personal photos
- [x] Is visual appeal prioritized over technical elegance? ✓ Card flip animations, celebration message
- [x] Would kids find this immediately engaging? ✓ Interactive clicking, immediate visual response

**II. Ship Fast**
- [x] Can this be shipped in hours/days (not weeks)? ✓ Simple vanilla JS, single HTML file
- [x] Are we avoiding complex build pipelines and elaborate testing? ✓ No build tools, manual testing only
- [x] No unnecessary performance optimization or multi-environment complexity? ✓ Local file, single environment

**III. Keep It Simple**
- [x] Using the simplest possible implementation? ✓ Vanilla JS, no frameworks
- [x] Avoiding microservices, ORMs, unnecessary abstractions? ✓ Single HTML file with inline JS/CSS
- [x] No design patterns unless obviously beneficial? ✓ Direct DOM manipulation
- [x] Single-file implementation where possible? ✓ index.html contains all code

**IV. Visual Feedback**
- [x] Does every user action have immediate visual feedback? ✓ Card flips, match highlights, timer updates
- [x] Are we using animations, transitions, or fun loading states? ✓ CSS transitions for card flips
- [x] Will users always know if their action worked? ✓ Visual confirmation on every click

**Violations Requiring Justification**: None - fully compliant with all constitutional principles.

## Project Structure

### Documentation (this feature)
```
specs/[###-feature]/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (repository root)
```
match/
├── index.html           # Single-file app (HTML + inline CSS/JS)
├── media/               # Photos for cards (10 images)
│   ├── PXL_20251006_012805987.jpg
│   ├── PXL_20251006_012832685.jpg
│   ├── PXL_20251006_012911401.jpg
│   ├── PXL_20251006_012926645.jpg
│   ├── PXL_20251006_013024904.jpg
│   ├── PXL_20251006_013127007.jpg
│   ├── PXL_20251006_013154729.jpg
│   ├── PXL_20251006_013222447.jpg
│   ├── PXL_20251006_013234429.jpg
│   └── PXL_20251006_013335597.jpg
└── README.md            # Quickstart instructions
```

**Structure Decision**: Single-file web application. All HTML, CSS, and JavaScript in `index.html` per "Keep It Simple" principle. No build process, no separate source files. Game reads photos directly from `media/` directory using relative paths.

## Phase 0: Outline & Research
1. **Extract unknowns from Technical Context** above:
   - For each NEEDS CLARIFICATION → research task
   - For each dependency → best practices task
   - For each integration → patterns task

2. **Generate and dispatch research agents**:
   ```
   For each unknown in Technical Context:
     Task: "Research {unknown} for {feature context}"
   For each technology choice:
     Task: "Find best practices for {tech} in {domain}"
   ```

3. **Consolidate findings** in `research.md` using format:
   - Decision: [what was chosen]
   - Rationale: [why chosen]
   - Alternatives considered: [what else evaluated]

**Output**: research.md with all NEEDS CLARIFICATION resolved

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities from feature spec** → `data-model.md`:
   - Entity name, fields, relationships
   - Validation rules from requirements
   - State transitions if applicable

2. **Generate API contracts** from functional requirements:
   - For each user action → endpoint
   - Use standard REST/GraphQL patterns
   - Output OpenAPI/GraphQL schema to `/contracts/`

3. **Generate contract tests** from contracts:
   - One test file per endpoint
   - Assert request/response schemas
   - Tests must fail (no implementation yet)

4. **Extract test scenarios** from user stories:
   - Each story → integration test scenario
   - Quickstart test = story validation steps

5. **Update agent file incrementally** (O(1) operation):
   - Run `.specify/scripts/bash/update-agent-context.sh claude`
     **IMPORTANT**: Execute it exactly as specified above. Do not add or remove any arguments.
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, failing tests, quickstart.md, agent-specific file

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Single HTML file implementation (all code in index.html)
- No separate test files (manual testing per quickstart.md)
- Focus on implementation tasks, not test-first (per constitution)
- Key sections to implement:
  - HTML structure (grid, cards, timer, celebration overlay)
  - CSS styling (grid layout, card flip animations, visual states)
  - JavaScript game logic (state management, event handlers, localStorage)
  - Photo loading and card rendering
  - Timer functionality
  - Match detection and win condition

**Ordering Strategy**:
- HTML structure first (static layout)
- CSS animations second (card flip effect)
- JavaScript third (game logic)
- localStorage integration fourth (persistence)
- Manual testing fifth (quickstart scenarios)
- NO parallel tasks (single file, sequential implementation)

**Estimated Output**: 10-12 numbered, sequential tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (execute tasks.md following constitutional principles)  
**Phase 5**: Validation (run tests, execute quickstart.md, performance validation)

## Complexity Tracking
*Fill ONLY if Constitution Check has violations that must be justified*

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command) - research.md created
- [x] Phase 1: Design complete (/plan command) - data-model.md, contracts/, quickstart.md, CLAUDE.md created
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS - All principles satisfied
- [x] Post-Design Constitution Check: PASS - Single HTML file approach maintains simplicity
- [x] All NEEDS CLARIFICATION resolved - 5 clarifications completed in spec
- [x] Complexity deviations documented - None (zero violations)

---
*Based on Constitution v1.0.0 - See `.specify/memory/constitution.md`*
