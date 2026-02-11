#!/usr/bin/env bun
// Reads from stdin and writes to stdout, ignoring all arguments.
process.stdin.pipe(process.stdout)
