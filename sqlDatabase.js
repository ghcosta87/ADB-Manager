function openDB() {
    try {
        var db = LocalStorage.openDatabaseSync(dbId, dbVersion,
                                               dbDescription, dbsize)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function startDatabase() {

    openDB().transaction(function (tx) {
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS dados_do_programa(indice numeric,nome text,valor text)')
        var comandosql = tx.executeSql('SELECT * FROM dados_do_programa')
        if (comandosql.rows.length === 0) {
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',
                          [1, "window_width", 600])
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',
                          [2, "window_height", 600])
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',
                          [3, "window_x", 0])
            tx.executeSql('INSERT INTO dados_do_programa VALUES(?,?,?)',
                          [4, "window_y", 0])
        }
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS dispositivos(nome text,ip text,image_path text,desc text)')
    })
}

function setSavedData() {
    openDB().transaction(function (tx) {
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [appWindow.width, "window_width"])
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [appWindow.height, "window_height"])
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [appWindow.x, "window_x"])
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [appWindow.y, "window_y"])
    })
}

function loadDevices() {
    var db = LocalStorage.openDatabaseSync(dbId, dbVersion,
                                           dbDescription, dbsize)

    //    devicesGrid.MyGrid.clear()
    devicesGrid.model.clear()
    var i
    var indice
    var nome
    var ip
    var image_path
    var desc
    //    l('SELECT rowid,date,trip_desc,distance FROM trip_log order by rowid desc')
    //                        'update trip_log set date=?, trip_desc=?, distance=? where rowid = ?', [Pdate, Pdesc, Pdistance, Prowid])
    openDB().transaction(function (tx) {
        //        var comandosql = tx.executeSql('SELECT rowid,nome,ip,image_path,desc FROM dispositivos order by rowid asc')
        var comandosql = tx.executeSql('SELECT rowid,nome,ip,image_path,desc FROM dispositivos')
        for (i = 0; i < comandosql.rows.length; i++) {
            devicesGrid.model.append({
                                         "grid_indice":  comandosql.rows.item(i).rowid,
                                         "grid_nome": comandosql.rows.item(i).nome,
                                         "grid_ip": comandosql.rows.item(i).ip,
                                         "grid_image_path": comandosql.rows.item(i).image_path,
                                         "grid_desc": comandosql.rows.item(i).desc
                                     })
        }
    })
}

function windowHandler(indice) {
    var db = LocalStorage.openDatabaseSync(dbId, dbVersion,
                                           dbDescription, dbsize)
    var retorno
    openDB().transaction(function (tx) {
        switch (indice) {
        case "window_width":
            retorno = (tx.executeSql(
                           'SELECT valor FROM dados_do_programa WHERE nome=?',
                           [indice])).rows.item(0).valor
            break
        case "window_height":
            retorno = (tx.executeSql(
                           'SELECT valor FROM dados_do_programa WHERE nome=?',
                           [indice])).rows.item(0).valor
            break
        case "window_x":
            retorno = (tx.executeSql(
                           'SELECT valor FROM dados_do_programa WHERE nome=?',
                           [indice])).rows.item(0).valor
            break
        case "window_y":
            retorno = (tx.executeSql(
                           'SELECT valor FROM dados_do_programa WHERE nome=?',
                           [indice])).rows.item(0).valor
            break
        }
    })
    return parseInt(retorno)
}

function registerDevice() {
    //    var rowid=0
    openDB().transaction(function (tx) {
        if (!remoteImageSelected) {
            image_path = "file:///" + image_path
            tx.executeSql('INSERT INTO dispositivos VALUES(?,?,?,?)',
                          [nome.text, ip.text, image_path.text, descricao.text])
        }
        if (remoteImageSelected) {
            tx.executeSql(
                        'INSERT INTO dispositivos VALUES(?,?,?,?)',
                        [nome.text, ip.text, grabResultImage.source, descricao.text])
        }
        //        var result=tx.executeSql('SELECT last_insert_rowid()')
        //        rowid=result.insertId
    })
    //    return rowid
}

function removeSelectedDevice(selectedId) {
    try{
        openDB().transaction(function (tx) {
            var result = tx.executeSql('SELECT rowid,* FROM dispositivos')
            console.log("selectedID: "+selectedId)
            console.log("row id: "+result.rows.item(selectedId).rowid )
            console.log("rows length: "+result.rows.length)
            tx.executeSql('delete from dispositivos where rowid = ?', [result.rows.item(selectedId).rowid ])
        })
    }catch(err){
        return null
    }
    return true
}
