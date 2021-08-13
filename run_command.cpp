//#include <QDebug>
#include <QCoreApplication>

#include "run_command.h"

QStringList arguments;
QString myPath;

run_command::run_command(QObject *parent) :
    QObject(parent),m_process(new QProcess(this))
{ 
    myPath = QCoreApplication::applicationDirPath();
}

QString run_command::grabPath(){
    return myPath;
}


void run_command::run(){
    qDebug()<<"comando 1 executado";
    QString command=myPath+"/scripts/adb_wifi_config.sh";
    m_process->start(command);
    //    m_process->start("bash /home/gabriel/.programas/adb-manager/adb_wifi_config.sh");
}

void run_command::console_fill(){
    qDebug()<<"comando 2 executado";
    QStringList arguments;
    arguments<<" ";
    QString command=myPath+"/scripts/data_import.sh";
    m_process->start(command,arguments);
}

void run_command::conectar_dispositivo(QString ip){
    qDebug()<<"comando 3 executado";
    m_process->start("bash /home/gabriel/.programas/adb-manager/conectar.sh -i "+ip);
}

void run_command::desconectar_dispositivos(){
    qDebug()<<"comando 4 executado";
    m_process->start("bash /home/gabriel/.programas/adb-manager/desconectar.sh");
}
