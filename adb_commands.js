
function a01_funcao_inicial(){    
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    db.transaction(function(tx){
        tx.executeSql('CREATE TABLE IF NOT EXISTS dados_do_programa(indice numeric,nome text,valor text)')
        var comandosql=tx.executeSql('SELECT * FROM dados_do_programa')
        if(comandosql.rows.length===0){
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',[1,"window_width",600])
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',[2,"window_height",600])
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',[3,"window_x",0])
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',[4,"window_y",0])
        }
        tx.executeSql('CREATE TABLE IF NOT EXISTS dispositivos(indice numeric,nome text,ip text,image_path text,desc text)')
    })
}

function a02_selecionar_constante(indice){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    var retorno
    db.transaction(function(tx){
        switch(indice){
        case "window_width":
            retorno=(tx.executeSql('SELECT valor FROM dados_do_programa WHERE nome=?',[indice])).rows.item(0).valor
            break
        case "window_height":
            retorno=(tx.executeSql('SELECT valor FROM dados_do_programa WHERE nome=?',[indice])).rows.item(0).valor
            break
        case "window_x":
            retorno=(tx.executeSql('SELECT valor FROM dados_do_programa WHERE nome=?',[indice])).rows.item(0).valor
            break
        case "window_y":
            retorno=(tx.executeSql('SELECT valor FROM dados_do_programa WHERE nome=?',[indice])).rows.item(0).valor
            break
        }
    })
    return parseInt(retorno)
}

function a03_setar_constantes(){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    db.transaction(function(tx){
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[janela_principal.width,"window_width"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[janela_principal.height,"window_height"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[janela_principal.x,"window_x"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[janela_principal.y,"window_y"]);
    })

    janela_principal.title="Android Debug Bridge - Manager"
}

function a04_carregar_dispositivos(){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    dispositivos.model.clear()
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
            dispositivos.model.append({
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
    var doc = new XMLHttpRequest();
    switch(selecao){
    case "ip":
        doc.open("GET", "file:///home/gabriel/.programas/adb-manager/ip.txt",true)
        //doc.open("GET","https://br.investing.com/currencies/usd-brl")
        break
    case "endereco":
        doc.open("GET", "file:///home/gabriel/.programas/adb-manager/endereco.txt",true)
        break
    case "modelo":
        doc.open("GET", "file:///home/gabriel/.programas/adb-manager/modelo.txt",true)
        break
    case "conexao":
        doc.open("GET", "file:///home/gabriel/.programas/adb-manager/conexao.txt",true)
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
    //console.debug(input)
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
    rodar_comando3.conectar_dispositivo(ip)
}
