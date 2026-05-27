#!/usr/bin/env bun

import { $, file, JSON5, write } from "bun"
import { mkdtemp } from "node:fs/promises"
import { tmpdir, userInfo } from "node:os"
import { join } from "node:path"

type Mapping = {
    remotePort: number
    localIp: string
    domain: string
}
type Config = {
    remoteUser: string
    remoteHost: string
    remotePort: number
    mappings: Mapping[]
}

const HOSTS_PATH = '/etc/hosts'
const END_OF_LINE_COMMENT = '#prieul-tunneling-script'
const INTERFACE = 'lo'

async function main() {
    let needIpAddressesReset = false
    let needHostsReset = false
    const config: Config = await readConf()

    async function cleanupWithNoFail(exitProcess: boolean, reason: string) {
        console.info('➜ Start cleanup: %s', reason)
        try {
            if (needIpAddressesReset) {
                console.info('➜ Will remove ip addresses')
                await removeIpAddresses(config)
                console.info('➜ ip addresses removed')
            }
            if (needHostsReset) {
                console.info('➜ Will reset hosts file')
                await resetHostsFile()
                console.info('➜ hosts file reset')
            }
            if (exitProcess) return process.exit(0)
        } catch (err) {
            console.error('An unexpected error occured during cleanup: %o', err)
            if (exitProcess) return process.exit(1)
        }
    }

    try {
        // Ensure cleanup will be made
        const handledSignals: Readonly<NodeJS.Signals[]> = ['SIGINT', 'SIGTERM'] as const
        for (const signal of handledSignals) {
            process.on(signal, async () => {
               await cleanupWithNoFail(true, signal.toString())
            })
        }

        // Add some local ip addresses
        console.info('➜ Will add ip addresses')
        await addIpAdresses(config)
        needIpAddressesReset = true

        // Modify hosts file
        console.info('➜ Will add hosts file')
        const entries = await modifyHostsFile(config)
        needHostsReset = true
        console.info('➜ hosts file was modified to add some entries: %o', entries)

        // SSH tunnel
        const sshCmd = buildSshCommand(config)
        console.info('➜ Will run the following command:\n\t> %s', sshCmd.join(' '))
        console.info('➜ When tunneling will be made, do not forget that only http is available for those domains (no https !)')
        const shellOutput = await $`${sshCmd}`
        console.info('➜ ssh exit code: %s', shellOutput.exitCode)
    } finally {
        await cleanupWithNoFail(true, 'finally > #main()')
    }
}
await main()

async function readConf(): Promise<Config> {
    const userHomeDir = userInfo().homedir
    const confFilePath = `${userHomeDir}/utils/config/prieul-tunneling/config.json5`
    console.info('➜ Configuration file: %s', confFilePath)
    const confFile = file(confFilePath)
    const confFileContent = await confFile.text()
    const config: Config = await JSON5.parse(confFileContent) as Config
    return config
}

function buildSshCommand(config: Config): string []{
    const cmd: string[] = ['sudo', 'ssh']
    for (const { remotePort, localIp, } of config.mappings) {
        cmd.push(`-L ${localIp}:80:localhost:${remotePort}`)
    }
    cmd.push('-N')
    cmd.push('-T')
    cmd.push(`${config.remoteUser}@${config.remoteHost}`)
    cmd.push(`-p ${config.remotePort}`)
    // cmd.push(`-t 'echo "SSH tunneling successfully made ! Ctrl-C to close the connection and end the program." && sleep infinity && echo "this should not be printed"'`)
    return cmd
}

async function addIpAdresses(config: Config) {
    const addrs = config.mappings.map(({ localIp }) => localIp)
    for (const addr of addrs) {
        console.info('➜ Will add ip %s', addr)
        try {
            await $`sudo ip address add ${addr}/8 dev ${INTERFACE}`
        } catch (err) {
            if (err instanceof $.ShellError) {
                console.info('\tFailed to add ip "%s" but maybe it was already existing. Error: %s - %s - %s', addr, err.exitCode, err.stdout.toString(), err.stderr.toString())
            }
        }
    }
}
async function removeIpAddresses(config: Config) {
    const addrs = config.mappings.map(({ localIp }) => localIp)
    for (const addr of addrs) {
        console.info('➜ Will delete ip %s', addr)
        await $`sudo ip address delete ${addr}/8 dev ${INTERFACE}`
    }
}

async function modifyHostsFile(config: Config): Promise<string[]> {
    const entries = config.mappings.map(({ localIp, domain }) => `${localIp} ${domain}`)
    // Use end-of-line comments so as to remove those entries later
    const entriesWithComment = entries.map((line) => `${line} ${END_OF_LINE_COMMENT}`)
    for (const line of entriesWithComment) {
        await $`echo "${line}" | sudo tee --append ${HOSTS_PATH}`
    }
    return entries
}
async function resetHostsFile() {
    const hostsFile = file(HOSTS_PATH)
    const oldContent = await hostsFile.text()
    const oldContentLines = oldContent
        .split('\n')
    const newContentLines = oldContentLines
        .filter((line) => !line.endsWith(END_OF_LINE_COMMENT))
    const newContent = newContentLines.join('\n')
    const tmpSubdir = await mkdtemp(join(tmpdir(), 'prieul-tunneling-work-'))
    console.info('➜ current hosts file number of lines: %s', oldContentLines.length)
    console.info('➜ new hosts file number of lines: %s', newContentLines.length)
    const tmpFilePath = `${tmpSubdir}/etc-hosts.tmp`
    console.info('➜ Will use tmp file %s', tmpFilePath)
    await write(file(tmpFilePath), newContent)
    await $`sudo cp ${tmpFilePath} ${HOSTS_PATH}`
}
