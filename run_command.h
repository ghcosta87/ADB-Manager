#ifndef RUN_COMMAND_H
#define RUN_COMMAND_H

#include <QObject>
#include <QProcess>

#include <QDebug>

class run_command : public QObject
{
    Q_OBJECT
public:
    explicit run_command(QObject *parent=0);
    Q_INVOKABLE void run();
    Q_INVOKABLE void console_fill();
    Q_INVOKABLE void conectar_dispositivo(QString);
    Q_INVOKABLE void desconectar_dispositivos();
    Q_INVOKABLE QString grabPath();
private:
    QProcess *m_process;
};

#endif // RUN_COMMAND_H
