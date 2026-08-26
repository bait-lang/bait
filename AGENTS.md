## Top Rules
- Use `./bait` only to build `bait2.js` (`./bait cli/bait.bt -o bait2.js`); Use `bun bait2.js` for everything else
- Rebuild `bait2.js` after compiler or core module changes, i.e.
  - `lib/bait/`
  - `lib/builtin/`


## Testing
- Run both backends: `bun bait2.js -b <js|c> test <path>`
- Default backend is JS; catch C-only regressions with `-b c`


## Commits, PRs
- Focused commits: one logical change
- Ask user in case of git conflicts
