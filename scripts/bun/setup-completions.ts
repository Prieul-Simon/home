#!/usr/bin/env bun

/**
 * This script retrieves for each program:
 * 1) The bash script for enabling completions in bash shell
 * 2) The fish script for enabling completions in fish shell, if needed (for instance fish seems to already integrate node,npm,tmux completions)
 */

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
        setupBat(),
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
    | 'bat'

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
    const completionFile = '../bashrc/sh/tmux.completion.bash'
    if (await testFileExists(category, completionFile)) return

    // const completionUrl = `https://raw.githubusercontent.com/Bash-it/bash-it/refs/heads/master/completion/available/tmux.completion.bash`
    const completionUrl = `https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux`
    const completionResult = await retrieveRawContent(category, completionUrl)
    await write(completionFile, completionResult)
    logSuccess(category, completionFile)
}

async function setupBun(category: Category = 'bun') {
    await Promise.allSettled([
        setupBunBash(category),
        setupBunFish(category),
    ])
}
async function setupBunBash(category: Category = 'bun') {
    const completionFile = '../bashrc/sh/bun.completion.bash'
    if (await testFileExists(category, completionFile)) return

    await $`bun completions > ${completionFile}`
    logSuccess(category, completionFile)
}
async function setupBunFish(category: Category = 'bun') {
    const completionFile = '../../config/fish/completions/bun.fish'
    if (await testFileExists(category, completionFile)) return

    await $`
        export SHELL="/usr/bin/fish"
        bun completions > ${completionFile}
    `
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

async function setupBat(category: Category = 'bat') {
    // as I made `alias bat='batcat'`, need to setup its autocomplete
    const completionFile = '../bashrc/sh/bat.completion.bash'
    if (await testFileExists(category, completionFile)) return

    const sourceFile = '/usr/share/bash-completion/completions/batcat'
    if (!await exists(sourceFile)) {
        syncLog(category, "Cannot find %s, the script is unable to generate completion file for bat alias command", sourceFile)
        return
    }
    await $`cp ${sourceFile} ${completionFile}`

    // Need to remove last line, so copy it with 'head' command (-n -1 removes the last line)
    await $`head -n -1 ${sourceFile} > ${completionFile}`
    // & replace it with another line at the end of the copied file
    await $`echo '} && complete -F _bat bat' >> ${completionFile}`

    logSuccess(category, completionFile)
}
