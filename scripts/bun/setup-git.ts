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
import { basename } from 'path'
import { getHomeFolder, retrieveRawContent, symlinkIfUnexisting } from "./src/common/common"

const absolutePointer = (home: string) => `${home}/utils/config/bash/bashrc/git/current`
const absoluteLocation = (home: string, v: string) => `${home}/utils/config/bash/bashrc/git/${v}`
const completionUrl = (v: string) => `https://raw.githubusercontent.com/git/git/${v}/contrib/completion/git-completion.bash`
const promptUrl = (v: string) => `https://raw.githubusercontent.com/git/git/${v}/contrib/completion/git-prompt.sh`

async function setupGit() {
    const home = await getHomeFolder()
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
            `${absoluteLocation(home, version)}/git-completion.bash`,
            `${absoluteLocation(home, version)}/git-prompt.sh`,
        ]
    if (completionResult?.status === 'fulfilled') {
        await write(completionFile, completionResult.value)
    }
    if (promptResult?.status === 'fulfilled') {
        await write(promptFile, promptResult.value)
    }
    // Create links
    await mkdir(absolutePointer(home), { recursive: true })
    await symlinkIfUnexisting(`../${version}/${basename(completionFile)}`, `${absolutePointer(home)}/git-completion.bash`)
    await symlinkIfUnexisting(`../${version}/${basename(promptFile)}`, `${absolutePointer(home)}/git-prompt.sh`)
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