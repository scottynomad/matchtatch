<!--
SYNC IMPACT REPORT
Version: 0.0.0 → 1.0.0
Rationale: Initial constitution creation for kids demo web app

Added Principles:
- I. Fun First
- II. Ship Fast
- III. Keep It Simple
- IV. Visual Feedback

Added Sections:
- Development Philosophy
- Quality Standards
- Governance

Templates Status:
- .specify/templates/plan-template.md: ✅ Updated Constitution Check section
- .specify/templates/spec-template.md: ✅ Updated Quick Guidelines
- .specify/templates/tasks-template.md: ✅ Updated testing approach and validation

Follow-up TODOs:
- None
-->

# Match Constitution

## Core Principles

### I. Fun First

Prioritize delightful user experience and playfulness over production-grade architecture.
Every feature MUST create joy or spark curiosity for kids. Technical elegance is secondary
to visual appeal and immediate gratification. If a feature isn't fun, it doesn't ship.

**Rationale**: This is a demo app for kids. Entertainment value trumps engineering purity.

### II. Ship Fast

Iteration speed is paramount. Features MUST be shipped in hours/days, not weeks. Avoid:
- Complex build pipelines
- Elaborate testing frameworks (basic smoke tests are fine)
- Performance optimization (unless visibly broken)
- Multi-environment deployments

**Rationale**: Quick feedback loops enable experimentation and keep kids engaged.

### III. Keep It Simple

Default to the simplest possible implementation. MUST avoid:
- Microservices or service layers
- ORMs or abstraction layers
- Design patterns (unless obviously beneficial)
- Configuration management systems
- State management libraries (start with component state)

Single-file implementations are encouraged. Refactor only when pain is felt.

**Rationale**: Over-engineering kills velocity and adds no value in a demo context.

### IV. Visual Feedback

Every user action MUST have immediate visual feedback. Prioritize:
- Animations and transitions
- Color changes and haptic cues
- Sound effects (when appropriate)
- Loading states that are fun (no boring spinners)

Users should never wonder "did that work?"

**Rationale**: Kids need constant engagement and confirmation that the app is responding.

## Development Philosophy

**Prototype Mindset**: This is a learning and exploration project. Code quality standards
are relaxed in favor of experimentation. Inline styles, hardcoded values, and copy-paste
are acceptable if they accelerate delivery.

**No Production Concerns**: Ignore scalability, observability, monitoring, error tracking,
security hardening (beyond basic XSS/CSRF), and deployment strategies. These are
explicitly out of scope.

**Embrace Quick Wins**: Use libraries and frameworks that provide instant results. Prefer:
- CSS frameworks with ready-made components
- UI libraries with animation built-in
- Hosted services over self-hosting (auth, DB, storage)

## Quality Standards

**Testing Philosophy**: Manual testing is primary. Automated tests are optional and should
only be added when they save time (e.g., preventing repeated manual checks of complex
flows). TDD is NOT required.

**Code Review**: Lightweight or skipped entirely. If working solo, ship immediately. If
collaborating, async reviews without blocking merges are fine.

**Documentation**: Only document what's non-obvious or magical. Prefer self-explanatory
code. README MUST exist with quickstart instructions.

## Governance

This constitution defines the development philosophy for the Match project. All features
and implementation decisions MUST align with the four core principles: Fun First, Ship
Fast, Keep It Simple, and Visual Feedback.

**Amendments**: Can be proposed anytime complexity creeps in or principles conflict.
Updates require justification and version bump per semantic versioning.

**Compliance**: Each feature should ask: "Does this add fun? Can we ship it faster?
Is this the simplest approach? Does it give clear feedback?" If any answer is no,
reconsider the approach.

**Version**: 1.0.0 | **Ratified**: 2025-10-05 | **Last Amended**: 2025-10-05
