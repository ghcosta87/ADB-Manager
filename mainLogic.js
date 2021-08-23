function grabPath() {
    myPath = runScript.grabPath()
}

function textToBool(input) {
    if (input === "true")
        return true
    if (input === "false" || input === null || input === undefined
            || input === "")
        return false
}
