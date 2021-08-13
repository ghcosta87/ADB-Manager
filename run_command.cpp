//#include <QDebug>

#include "run_command.h"

QStringList arguments;

run_command::run_command(QObject *parent) :
    QObject(parent),m_process(new QProcess(this))
{
}

void run_command::run(){
    qDebug()<<"comando 1 executado";
    m_process->start("bash /home/gabriel/.programas/adb-manager/adb_wifi_config.sh");
}

void run_command::console_fill(){
    qDebug()<<"comando 2 executado";
    m_process->start("bash /home/gabriel/.programas/adb-manager/data_import.sh");
}

void run_command::conectar_dispositivo(QString ip){
    qDebug()<<"comando 3 executado";   
    m_process->start("bash /home/gabriel/.programas/adb-manager/conectar.sh -i "+ip);
}

void run_command::desconectar_dispositivos(){
    qDebug()<<"comando 4 executado";
    m_process->start("bash /home/gabriel/.programas/adb-manager/desconectar.sh");
}
