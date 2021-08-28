function getTimeStamp() {
    var today = new Date()
    var date = today.getFullYear() + '-' + (today.getMonth(
                                                ) + 1) + '-' + today.getDate()
    var time = today.getHours() + ":" + today.getMinutes(
                ) + ":" + today.getSeconds()
    var dateTime = date + ' ' + time
    return dateTime
}

function openDB() {
    try {
        var db = LocalStorage.openDatabaseSync(dbId, dbVersion,
                                               dbDescription, dbsize)
    } catch (err) {
        consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                    ) + ' - Error while opening the Database</p>'
    }
    return db
}

function startDatabase() {
    openDB().transaction(function (tx) {
        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS dados_do_programa(indice numeric,nome text,valor text)')
        consoleLogLineNumbers++
        consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                    ) + ' - ProgramData Database created if not exist generated</p>'
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
            consoleLogLineNumbers++
            consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                        ) + ' - Window position and size setted to default </p>'
        } else {
            consoleLogLineNumbers++
            consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                        ) + ' - Window position and size loaded </p>'
        }

        tx.executeSql(
                    'CREATE TABLE IF NOT EXISTS dispositivos(nome text,ip text,image_path text,desc text)')
        consoleLogLineNumbers++
        consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                    ) + ' - Devices Database created if not exist generated</p>'
    })
}

function setSavedData() {
    openDB().transaction(function (tx) {
        consoleLogLineNumbers++
        consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                    ) + ' - Window position and size stored </p>'
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [root.width, "window_width"])
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [root.height, "window_height"])
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [root.x, "window_x"])
        tx.executeSql('UPDATE dados_do_programa SET valor=? WHERE nome=?',
                      [root.y, "window_y"])
    })
}

function loadDevices() {
    var db = LocalStorage.openDatabaseSync(dbId, dbVersion,
                                           dbDescription, dbsize)
    devicesGrid.model.clear()
    var i
    var indice
    var nome
    var ip
    var image_path
    var desc
    try {
        openDB().transaction(function (tx) {
            //        var comandosql = tx.executeSql('SELECT rowid,nome,ip,image_path,desc FROM dispositivos order by rowid asc')
            var comandosql = tx.executeSql(
                        'SELECT rowid,nome,ip,image_path,desc FROM dispositivos')
            for (i = 0; i < comandosql.rows.length; i++) {
                devicesGrid.model.append({
                                             "grid_indice": comandosql.rows.item(
                                                                i).rowid,
                                             "grid_nome": comandosql.rows.item(
                                                              i).nome,
                                             "grid_ip": comandosql.rows.item(
                                                            i).ip,
                                             "grid_image_path": comandosql.rows.item(
                                                                    i).image_path,
                                             "grid_desc": comandosql.rows.item(
                                                              i).desc
                                         })
            }
            consoleLogLineNumbers++
            consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                        ) + ' - Finish to read from devices database </p>'
        })
    } catch (err) {
        consoleLogLineNumbers++
        consoleLog.text = consoleLog.text + '<p> ' + getTimeStamp(
                    ) + ' - Error reading devices database </p>'
    }
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

    try{
    openDB().transaction(function (tx) {
        if (!remoteImageSelected) {
            image_path = "file:///" + image_path
            tx.executeSql('INSERT INTO dispositivos VALUES(?,?,?,?)',
                          [nome.text, ip.text, image_path.text, descricao.text])
        }
        consoleLogLineNumbers++
        consoleLog.text=consoleLog.text+'<p> '+getTimeStamp()+' - Device added with local image</p>'
        if (remoteImageSelected) {
            tx.executeSql(
                        'INSERT INTO dispositivos VALUES(?,?,?,?)',
                        [nome.text, ip.text, grabResultImage.source, descricao.text])
            consoleLogLineNumbers++
            consoleLog.text=consoleLog.text+'<p> '+getTimeStamp()+' - Device added with remote image</p>'
        }

    })}catch(err){
        consoleLogLineNumbers++
        consoleLog.text=consoleLog.text+'<p> '+getTimeStamp()+' - An error occurred while registering the device</p>'
    }
}

function removeSelectedDevice(selectedId) {
    try {
        openDB().transaction(function (tx) {
            var result = tx.executeSql('SELECT rowid,* FROM dispositivos')
            tx.executeSql('delete from dispositivos where rowid = ?',
                          [result.rows.item(selectedId).rowid])
        })
        consoleLogLineNumbers++
        consoleLog.text=consoleLog.text+'<p> '+getTimeStamp()+' - Device removed</p>'
    } catch (err) {
        consoleLogLineNumbers++
        consoleLog.text=consoleLog.text+'<p> '+getTimeStamp()+' - Error while removing the device</p>'
        return null
    }
    return true
}
