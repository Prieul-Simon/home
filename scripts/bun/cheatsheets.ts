#!/usr/bin/env bun
import { parseArgs } from 'util'

async function printCheatsheet(name?: string): Promise<void> {
    const text = await getCheatsheet(name)
    const markdown = toMarkdown(text)
    process.stdout.write(markdown)
    process.stdout.write('\n')
}

async function getCheatsheet(name?: string): Promise<string> {
    const filename = `cheatsheets/${name}.md`
    const absolute = `${import.meta.dir}/${filename}`
    const file = Bun.file(absolute)
    const exists = await file.exists()
    if (!exists) {
        return `No cheatsheet found with name ${file.name}`
    }

    const content = await file.text()
    return content
}

function toMarkdown(text: string): string {
    // ANSI terminal output
    const ansi = Bun.markdown.render(text, {
        heading: (children, meta) => {
            const indent = new Array(meta.level).fill(' ').join('')
            return `${indent}\x1b[1;4m${children}\x1b[0m\n`
        },
        paragraph: (children) => children + "\n",
        strong: (children) => `\x1b[1m${children}\x1b[22m`,
    });
    return ansi
}

const { values } = parseArgs({
    args: Bun.argv,
    options: {
        name: {
            type: 'string',
        }
    },
    allowPositionals: true,
})
await printCheatsheet(values.name)
process.exit(0)