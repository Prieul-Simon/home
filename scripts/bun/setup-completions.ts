#!/usr/bin/env bun

import { $, write } from "bun"
import { retrieveRawContent as commonRetrieveRawContent } from "./src/common/common"
import { exists } from "fs/promises"

async function setupAll() {
    await Promise.allSettled([
        setupTmux(),
        setupBun(),
        setupNpm(),
        setupNode(),
        setupTldr(),
    ])
}

await setupAll()
process.exit(0)

type Category = 
    | 'tmux'
    | 'bun'
    | 'npm'
    | 'node'
    | 'tldr'

function syncLog(category: Category, msg: string, ...data: any[]) {
    const beginCategory = `[${category}]`
    const endCategory = `[${category}]`
    console.info(beginCategory)
    console.info(`    ${msg}`, ...data) // indent 4 spaces
    console.info(endCategory)
}

async function testFileExists(category: Category, filePath: string): Promise<boolean> {
    if (await exists(filePath)) {
        syncLog(category, "%s already exists, the script won't try to re-fetch it", filePath)
        return true
    }
    return false
}
function logSuccess(category: Category, filePath: string) {
    syncLog(category, "%s created !", filePath)
}

async function retrieveRawContent(category: Category, url: string): Promise<string> {
    return await commonRetrieveRawContent(
        url,
        (msg: string) => syncLog(category, msg)
    )
}

async function setupTmux(category: Category = 'tmux') {
    const relativeLocation = `../bashrc/tmux`
    const completionFile = `${relativeLocation}/tmux.completion.bash`
    if (await testFileExists(category, completionFile)) return

    // const completionUrl = `https://raw.githubusercontent.com/Bash-it/bash-it/refs/heads/master/completion/available/tmux.completion.bash`
    const completionUrl = `https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux`

    const [completionResult] = await Promise.allSettled<string>([
        retrieveRawContent(category, completionUrl),
    ])

    // Create real files
    if (completionResult?.status === 'fulfilled') {
        await write(completionFile, completionResult.value)
        logSuccess(category, completionFile)
    }
}

async function setupBun(category: Category = 'bun') {
    const completionFile = '../bashrc/sh/bun.completion.bash'
    if (await testFileExists(category, completionFile)) return

    await $`bun completions > ${completionFile}`
    logSuccess(category, completionFile)
}

async function setupNpm(category: Category = 'npm') {
    const completionFile = '../bashrc/sh/npm.completion.sh'
    if (await testFileExists(category, completionFile)) return

    await $`npm completion > ${completionFile}`
    logSuccess(category, completionFile)
}

async function setupNode(category: Category = 'node') {
    const completionFile = '../bashrc/sh/node.completion.bash'
    if (await testFileExists(category, completionFile)) return

    await $`node --completion-bash > ${completionFile}`
    logSuccess(category, completionFile)
}

async function setupTldr(category: Category = 'tldr') {
    const completionFile = '../bashrc/sh/tldr.completion.bash'
    if (await testFileExists(category, completionFile)) return

    const completionUrl = `https://raw.githubusercontent.com/tldr-pages/tldr-node-client/refs/heads/main/bin/completion/bash/tldr`
    const completionResult = await retrieveRawContent(category, completionUrl)
    await write(completionFile, completionResult)
    logSuccess(category, completionFile)
}
