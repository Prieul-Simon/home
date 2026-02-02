import type { PathLike } from "fs"
import { exists, symlink } from "fs/promises"

export async function retrieveRawContent(url: string): Promise<string> {
    console.info(`Fetching '${url}'...`)
    const rawContent = await fetch(url)
    if (rawContent.status !== 200) {
        console.error('Not the expected result from GitHub: %o', rawContent)
        process.exit(1)
    }
    console.info(`End fetching '${url}' with success`)
    return rawContent.text()
}

export async function symlinkIfUnexisting(target: PathLike, nameLinkToCreate: PathLike) {
    if (await exists(nameLinkToCreate)) {
        console.info(`Will not create '${nameLinkToCreate}' as it already exists`)
        return
    }
    await symlink(target, nameLinkToCreate)
}
