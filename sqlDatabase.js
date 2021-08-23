function startDatabase(){
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

function setSavedData(){
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    db.transaction(function(tx){
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.width,"window_width"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.height,"window_height"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.x,"window_x"]);
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',[appWindow.y,"window_y"]);
    })
}

function loadDevices(){
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

function windowHandler(indice){
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

function registerDevice(){
    console.debug(grabResultImage.source+" - "+remoteImageSelected)
    var db=LocalStorage.openDatabaseSync(dbId,dbVersion,dbDescription,dbsize)
    db.transaction(function(tx){
        var indice = (tx.executeSql('SELECT * FROM dispositivos')).rows.length
        if(!remoteImageSelected)
            image_path="file:///"+image_path
            tx.executeSql('INSERT INTO dispositivos VALUES(?,?,?,?,?)'
                          ,[(indice+1),nome.text,ip.text,image_path.text,descricao.text])
        if(remoteImageSelected)
            tx.executeSql('INSERT INTO dispositivos VALUES(?,?,?,?,?)'
                          ,[(indice+1),nome.text,ip.text,grabResultImage.source,descricao.text])
    })
}
