## Workflow for compiler changes
- Never run `bait self`
- Build `bait2.js`: `./bait cli/bait.bt -o bait2.js`
- Use `bun bait2.js` for all checks

## Workflow for non-compiler changes (library code, tests, etc.)
- Use `./bait` directly (no need to build `bait2.js`)
