#!/usr/bin/env bun

import { write } from "bun"
import { retrieveRawContent } from "./src/common/common"

const RELATIVE_LOCATION = `../bashrc/tmux`
// const completionUrl = `https://raw.githubusercontent.com/Bash-it/bash-it/refs/heads/master/completion/available/tmux.completion.bash`
const completionUrl = `https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux`

async function setupTmux() {
    const [completionResult] = await Promise.allSettled<string>([
        retrieveRawContent(completionUrl),
    ])

    // Create real files
    const completionFile = `${RELATIVE_LOCATION}/tmux.completion.bash`
    if (completionResult?.status === 'fulfilled') {
        await write(completionFile, completionResult.value)
    }
    console.info('setup-tmux-completions finished !')
}

await setupTmux()
process.exit(0)