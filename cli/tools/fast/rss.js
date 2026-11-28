// SPDX-FileCopyrightText: Lukas Neubert <lukas.neubert@proton.me>
// SPDX-License-Identifier: MIT

// Runs a native command and reports its peak resident set size like mem.js does for bun
const proc = Bun.spawn(process.argv.slice(2), { stdout: 'inherit', stderr: 'inherit' })
await proc.exited
const usage = proc.resourceUsage()
if (usage) {
	// Bun reports bytes here, but KB for `process.resourceUsage()`
	console.error(`FAST_MAXRSS_KB=${Math.round(usage.maxRSS / 1024)}`)
}
process.exit(proc.exitCode ?? 1)
