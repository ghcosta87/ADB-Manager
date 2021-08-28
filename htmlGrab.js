var myValueObjects

function getTimeStamp() {
    var today = new Date()
    var date = today.getFullYear() + '-' + (today.getMonth(
                                                ) + 1) + '-' + today.getDate()
    var time = today.getHours() + ":" + today.getMinutes(
                ) + ":" + today.getSeconds()
    var dateTime = date + ' ' + time
    return dateTime
}


function grabImage(device) {
    try {
        var xhr = new XMLHttpRequest()

        let newSearchString = device.replace(" ", "+")
        var bingImageSearch = "https://bing-image-search1.p.rapidapi.com/images/search?q="
                + newSearchString + "&count=" + maximumImageResults

        var texto_html
        var textFilter

        xhr.withCredentials = true

        xhr.open("GET", bingImageSearch, true)
        xhr.setRequestHeader("x-rapidapi-host",
                             "bing-image-search1.p.rapidapi.com")
        xhr.setRequestHeader(
                    "x-rapidapi-key",
                    "4e0a7247damsh80eefb6da7ce25ap1f6174jsn739f2d802cc5")

        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {

            } else if (xhr.readyState === xhr.DONE) {
                texto_html = xhr.responseText
                textFilter = texto_html.replace(/[\\]/g, '')
                runScript.debugNetGraber(textFilter)
                jsonSpliter(textFilter, 0, 0)
                loading_iamge_gif_visibility.text = "false"
            }
        }
        xhr.send(data)
    } catch (err) {
        consoleLogLineNumbers++
        consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                    ) + ' - Error while search the image on internet</p>'
    }
}

function jsonSpliter(myJson, request, picture) {
    switch (request) {
    case 0:
        try {
            var myObject = JSON.parse(myJson)
            const myValueJson = JSON.stringify(myObject.value)
            myValueObjects = JSON.parse(myValueJson)
            grabResultImage.source = myValueObjects[0].contentUrl
            consoleLogLineNumbers++
            consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                        ) + ' - Sucesso ao procurar imagem</p>'
        } catch (e) {
            searchBox.text = "Nada encontrado ... Tente novamente"
            consoleLogLineNumbers++
            consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                        ) + ' - Nenhuma imagem encontrada</p>'
        }
        break
    case 1:
        try {
            grabResultImage.source = myValueObjects[picture].contentUrl
            consoleLogLineNumbers++
            consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                        ) + ' - Imagem carregada</p>'
        } catch (err) {
            consoleLogLineNumbers++
            consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                        ) + ' - Erro ao carregar a imagem</p>'
        }
    }
}
