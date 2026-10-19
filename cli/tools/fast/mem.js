// SPDX-FileCopyrightText: Lukas Neubert <lukas.neubert@proton.me>
// SPDX-License-Identifier: MIT

// Preloaded into the measured compiler to report its peak resident set size (KB on Linux)
process.on('exit', () => console.error(`FAST_MAXRSS_KB=${process.resourceUsage().maxRSS}`))
