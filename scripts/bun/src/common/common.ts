import type { PathLike } from "fs"
import { exists, symlink } from "fs/promises"

export async function retrieveRawContent(
    url: string, 
    logFn?: typeof console.info,
    errorFn?: typeof console.error,
): Promise<string> {
    log(`Fetching '${url}'...`, logFn)
    const rawContent = await fetch(url)
    if (rawContent.status !== 200) {
        error('Not the expected result from GitHub: %o', rawContent, errorFn)
        process.exit(1)
    }
    log(`End fetching '${url}' with success`, logFn)
    return rawContent.text()
}

export async function symlinkIfUnexisting(
    target: PathLike, 
    nameLinkToCreate: PathLike,
    logFn?: typeof console.info,
) {
    if (await exists(nameLinkToCreate)) {
        log(`Will not create '${nameLinkToCreate}' as it already exists`, logFn)
        return
    }
    await symlink(target, nameLinkToCreate)
}

function log(msg: string, logFn?: typeof console.info) {
    if (logFn) {
        logFn(msg)
    } else {
        console.info(msg)
    }
}

function error(msg: string, data: any, errorFn?: typeof console.error) {
    if (errorFn) {
        errorFn(msg, data)
    } else {
        console.error(msg, data)
    }
}
