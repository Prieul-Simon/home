#!/usr/bin/env bun

/**
 * This script retrieves:
 * 1) The bash script for enabling completions in bash shell
 * 2) The bash script for exposing functions for integrating git status in the prompt of the bash shell
 * 
 * There is no need to do the same for fish as fish already integrates git in the prompt and already integrate git completions
 */
import { $, write } from "bun"
import { mkdir } from 'fs/promises'
import { resolve } from 'path'
import { retrieveRawContent, symlinkIfUnexisting } from "./src/common/common"

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
    await symlinkIfUnexisting(resolve(completionFile), `${RELATIVE_POINTER}/git-completion.bash`)
    await symlinkIfUnexisting(resolve(promptFile), `${RELATIVE_POINTER}/git-prompt.sh`)
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

await setupGit()
process.exit(0)