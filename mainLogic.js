function getTimeStamp() {
    var today = new Date()
    var date = today.getFullYear() + '-' + (today.getMonth(
                                                ) + 1) + '-' + today.getDate()
    var time = today.getHours() + ":" + today.getMinutes(
                ) + ":" + today.getSeconds()
    var dateTime = date + ' ' + time
    return dateTime
}

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
