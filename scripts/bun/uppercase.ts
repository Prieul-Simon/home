#!/usr/bin/env bun

/**
 * Usage
 * uppercase "événement" => return "ÉVÉNEMENT"
 * echo -n "événement" | uppercase => return "ÉVÉNEMENT"
 */

const text = process.argv.at(-1)
if (text && process.argv.length >= 3) {
    await __writeStdoutInUppercase(text)
    process.exit(0)
} else if (process.stdin.isTTY === false || process.stdin.isTTY === undefined) {
    await __readFromStdin()
    process.exit(0)
}
await Bun.stderr.write('Missing text argument or stdin\n')
process.exit(1)

async function __readFromStdin() {
    for await (const chunk of Bun.stdin.stream()) {
        const chunkText = Buffer.from(chunk).toString()
        await __writeStdoutInUppercase(chunkText)
    }
}

async function __writeStdoutInUppercase(text: string) {
    return await Bun.write(Bun.stdout, text.toUpperCase())
}
