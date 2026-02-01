#!/usr/bin/env bun

/**
 * Usage
 * bun_cat ./path-to-file
 * According to https://bun.sh/docs/runtime/file-io#benchmarks it runs 2x faster than GNU cat for large files on Linux.
 */
import { resolve } from 'path'

const file = process.argv.at(-1)
if (!file || process.argv.length < 3) {
    await Bun.stderr.write('Missing file argument\n')
    process.exit(1)
}
const path = resolve(file)
await Bun.write(Bun.stdout, Bun.file(path))
