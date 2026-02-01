#!/usr/bin/env bun

import { $, write } from "bun"
import { mkdir, symlink } from 'fs/promises'
import { resolve} from 'path'

const RELATIVE_POINTER = `../bashrc/git/current`
const relativeLocation = (v: string) => `../bashrc/git/${v}`
const completionUrl = (v: string) => `https://raw.githubusercontent.com/git/git/${v}/contrib/completion/git-completion.bash`
const promptUrl = (v: string) => `https://raw.githubusercontent.com/git/git/${v}/contrib/completion/git-prompt.sh`

async function setupGit() {
    const version = await getVersion()
    const [completionResult, promptResult] = await Promise.allSettled<string>([
        retrieveRawContent(completionUrl(version)),
        retrieveRawContent(promptUrl(version)),
    ])

    // Create real files
    const [
        completionFile,
        promptFile,
    ] = [
        `${relativeLocation(version)}/git-completion.bash`,
        `${relativeLocation(version)}/git-prompt.sh`,
    ]
    if (completionResult?.status === 'fulfilled') {
        await write(completionFile, completionResult.value)
    }
    if (promptResult?.status === 'fulfilled') {
        await write(promptFile, promptResult.value)
    }
    // Create links
    await mkdir(RELATIVE_POINTER, { recursive: true })
    await symlink(resolve(completionFile), `${RELATIVE_POINTER}/git-completion.bash`)
    await symlink(resolve(promptFile), `${RELATIVE_POINTER}/git-prompt.sh`)
    console.info('setup-git finished !')
}

async function getVersion(): Promise<string> {
    const full = await $`git --version`.text()
    const start = 'git version '
    if (!full.startsWith(start)) {
        throw new Error('Unexpected git version format')
    }
    const vNumber = full.substring(start.length).trim()
    const version = `v${vNumber}`
    console.info(`Found version ${version}`)
    return version
}

async function retrieveRawContent(url: string): Promise<string> {
    console.info(`Fetching '${url}'...`)
    const rawContent = await fetch(url)
    if (rawContent.status !== 200) {
        console.error('Not the expected result from GitHub: %o', rawContent)
        process.exit(1)
    }
    console.info(`End fetching '${url}' with success`)
    return rawContent.text()
}

await setupGit()
process.exit(0)