//#include <QDebug>
#include <QCoreApplication>
#include <QFile>
#include "run_command.h"

QStringList arguments;
QString myPath;


run_command::run_command(QObject *parent) :
    QObject(parent),m_process(new QProcess(this))
{
    myPath = QCoreApplication::applicationDirPath();
    QStringList arguments;
    arguments<<" ";
}

QString run_command::grabPath(){
    return myPath;
}


void run_command::setWifiConnection(){
    QString command=myPath+"/scripts/adb_wifi_config.sh";
    m_process->start(command,arguments);   
}

void run_command::console_fill(){
    QString command=myPath+"/scripts/data_import.sh";
    m_process->start(command,arguments);
}

void run_command::conectar_dispositivo(QString ip){
    QString command="bash /home/gabriel/.programas/adb-manager/conectar.sh -i "+ip;
    m_process->start(command,arguments);
}

void run_command::desconectar_dispositivos(){
    QString command="bash /home/gabriel/.programas/adb-manager/adb_wifi_disconnect.sh";
    m_process->start(command,arguments);
}

void run_command::debugNetGraber(QString dataToDebug){
    qDebug()<<"comando debugNetGraber(QString dataToDebug) executado";
    QFile originalFile(myPath+"/querys/originalGET.json");
    if (!originalFile.open(QIODevice::WriteOnly | QIODevice::Text))
        return;
    QTextStream originalOutput(&originalFile);
    originalOutput << dataToDebug;
}
