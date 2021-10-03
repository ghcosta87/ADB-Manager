function getTimeStamp() {
    var today = new Date()
    var date = today.getFullYear() + '-' + (today.getMonth(
                                                ) + 1) + '-' + today.getDate()
    var time = today.getHours() + ":" + today.getMinutes(
                ) + ":" + today.getSeconds()
    var dateTime = date + ' ' + time
    return dateTime
}



function a06_ler_arquivos(selecao){
    var myPath=runScript.grabPath()
    var doc = new XMLHttpRequest();
    switch(selecao){
    case "ip":
        doc.open("GET", "file://"+myPath+"/ip.txt",true)
        //        doc.open("GET", "file:///home/gabriel/.programas/adb-manager/ip.txt",true)
        //doc.open("GET","https://br.investing.com/currencies/usd-brl")
        break
    case "endereco":
        doc.open("GET","file://"+myPath+"/endereco.txt",true)
        break
    case "modelo":
        doc.open("GET","file://"+myPath+"/modelo.txt",true)
        break
    case "conexao":
        doc.open("GET","file://"+myPath+"/conexao.txt",true)
        break
    }
    console_area_text.text = "";
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
        } else if (doc.readyState === XMLHttpRequest.DONE) {
            var linha =2
            var a = doc.response
            var b =a.trim()
            loading_gif_visibility.text="false"
            loading_text_visibility.text="false"
            loading_text_context.text="DONE !"
            switch(selecao){
            case "ip":
                showRequestInfo("IP: "+b)
                break
            case "endereco":
                showRequestInfo("Endereço: "+b)
                break
            case "modelo":
                showRequestInfo("Modelo: "+b)
                break
            case "conexao":
                set_console_title(b)
                break
            }
        }
    }
    doc.send();
}

function showRequestInfo(input) {
    if(input!=="#text")console_area_text.text = console_area_text.text + "\n" + input
}

function set_console_title(input){
    if(input!=="#text"){
        var retorno = parseInt(input)
        if(retorno===0)console_title_text.text= "## - SEM CONEXÃO - ##"
        if(retorno===1)console_title_text.text= "- DISPOSITIVO CONECTADO -"
    }
}

function load_content(){
    a06_ler_arquivos("ip")
    a06_ler_arquivos("endereco")
    a06_ler_arquivos("modelo")
    a06_ler_arquivos("conexao")
}

function a07_conectar_dispositivos(indice){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    var ip
    db.transaction(function(tx){
        var comandosql = tx.executeSql('SELECT * FROM dispositivos')
        ip=comandosql.rows.item(0).ip
    })
    runScript.conectar_dispositivo(ip)
}


