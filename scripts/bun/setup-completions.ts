#!/usr/bin/env bun

import { $, write } from "bun"
import { retrieveRawContent } from "./src/common/common"

async function setupAll() {
    await Promise.allSettled([
        setupTmux(),
        setupBun(),
        setupNpm(),
        setupNode(),
        setupTldr(),
    ])
}

async function setupTmux() {
    const relativeLocation = `../bashrc/tmux`
    // const completionUrl = `https://raw.githubusercontent.com/Bash-it/bash-it/refs/heads/master/completion/available/tmux.completion.bash`
    const completionUrl = `https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux`

    const [completionResult] = await Promise.allSettled<string>([
        retrieveRawContent(completionUrl),
    ])

    // Create real files
    const completionFile = `${relativeLocation}/tmux.completion.bash`
    if (completionResult?.status === 'fulfilled') {
        await write(completionFile, completionResult.value)
    }
    console.info('setup-tmux-completions finished !')
}

async function setupBun() {
    await $`bun completions > ../bashrc/sh/bun.completion.bash`
}

async function setupNpm() {
    await $`npm completion > ../bashrc/sh/npm.completion.sh`
}

async function setupNode() {
    await $`node --completion-bash > ../bashrc/sh/node.completion.bash`
}

async function setupTldr() {
    const completionUrl = `https://raw.githubusercontent.com/tldr-pages/tldr-node-client/refs/heads/main/bin/completion/bash/tldr`
    const completionResult = await retrieveRawContent(completionUrl)
    await write('../bashrc/sh/tldr.completion.bash', completionResult)
}

await setupAll()
process.exit(0)