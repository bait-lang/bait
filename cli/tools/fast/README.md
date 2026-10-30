# fast
Measures compiler self-compilation time across commits.
Results: [bait-lang/fast](https://github.com/bait-lang/fast).

## Usage
```sh
bait fast [options]       # Measure new commits and render results
bait fast -c 1a2b3c4     # Measure one commit without storing results
```

| Option              | Default | Description                                           |
| ------------------- | ------- | ----------------------------------------------------- |
| `-r`, `--runs`      | `5`     | Runs per commit; keep the minimum of each measurement |
| `-m`, `--max`       | `10`    | Maximum commits per invocation                        |
| `-c`, `--commit`    |         | Print one commit's result instead of storing it       |
| `-n`, `--no-render` |         | Skip rendering `index.html`                           |
| `-p`, `--push`      |         | Commit and push results                               |

Examples:
```sh
# Measure new commits on main and render the results
bait fast

# Check the impact of a commit without storing anything
bait fast -c 1a2b3c4
```

## How it works
For each commit, it bootstraps the compiler (`stable bait.js → fast1.js → fast.js`), then runs `fast.js --timings cli/bait.bt` repeatedly. Failed builds or runs store only commit information.

The [fast workflow](../../../.github/workflows/fast.yml) runs `bait fast --push` daily. Pushing can authenticate with `TIABEAST_BOT_TOKEN`.
