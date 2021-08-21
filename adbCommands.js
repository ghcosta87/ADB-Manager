
function a03_setar_constantes(){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    db.transaction(function(tx){
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.width,"window_width"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.height,"window_height"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.x,"window_x"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.y,"window_y"]);
    })

//    janela_principal.title="Android Debug Bridge - Manager"
}

function a04_carregar_dispositivos(){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    devicesGrid.model.clear()
    var i
    var indice; var nome; var ip; var image_path; var desc
    db.transaction(function(tx){
        var comandosql=tx.executeSql('SELECT * FROM  dispositivos')
        for(i=0;i<comandosql.rows.length;i++){
            indice=comandosql.rows.item(i).indice
            nome=comandosql.rows.item(i).nome
            ip=comandosql.rows.item(i).ip
            image_path=comandosql.rows.item(i).image_path
            desc=comandosql.rows.item(i).desc
            devicesGrid.model.append({
                                          grid_indice:indice,
                                          grid_nome:nome,
                                          grid_ip:ip,
                                          grid_image_path:image_path,
                                          grid_desc:desc
                                      })
        }
    })
}

function a05_cadastrar_dispositivo(selecao){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    db.transaction(function(tx){
        var indice = (tx.executeSql('SELECT * FROM dispositivos')).rows.length
        tx.executeSql('INSERT INTO dispositivos VALUES(?,?,?,?,?)'
                      ,[(indice+1),nome.text,ip.text,image_path.text,descricao.text])
    })
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
    console_area.text = "";
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
        } else if (doc.readyState === XMLHttpRequest.DONE) {
            var linha =2
            var a = doc.response
            var b =a.trim()
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
    //    console.debug(input)
    if(input!=="#text")console_area.text = console_area.text + "\n" + input
}

function set_console_title(input){
    if(input!=="#text"){
        var retorno = parseInt(input)
        if(retorno===0)console_title.text= "## - SEM CONEXÃO - ##"
        if(retorno===1)console_title.text= "- DISPOSITIVO CONECTADO -"
    }
}

function ler_arquivos(){
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


