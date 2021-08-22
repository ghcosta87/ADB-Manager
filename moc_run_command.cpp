/****************************************************************************
** Meta object code from reading C++ file 'run_command.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "run_command.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'run_command.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_run_command_t {
    QByteArrayData data[12];
    char stringdata0[128];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_run_command_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_run_command_t qt_meta_stringdata_run_command = {
    {
QT_MOC_LITERAL(0, 0, 11), // "run_command"
QT_MOC_LITERAL(1, 12, 3), // "run"
QT_MOC_LITERAL(2, 16, 0), // ""
QT_MOC_LITERAL(3, 17, 12), // "console_fill"
QT_MOC_LITERAL(4, 30, 20), // "conectar_dispositivo"
QT_MOC_LITERAL(5, 51, 24), // "desconectar_dispositivos"
QT_MOC_LITERAL(6, 76, 8), // "grabPath"
QT_MOC_LITERAL(7, 85, 14), // "debugNetGraber"
QT_MOC_LITERAL(8, 100, 6), // "query1"
QT_MOC_LITERAL(9, 107, 6), // "query2"
QT_MOC_LITERAL(10, 114, 6), // "query3"
QT_MOC_LITERAL(11, 121, 6) // "query4"

    },
    "run_command\0run\0\0console_fill\0"
    "conectar_dispositivo\0desconectar_dispositivos\0"
    "grabPath\0debugNetGraber\0query1\0query2\0"
    "query3\0query4"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_run_command[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    0,   64,    2, 0x02 /* Public */,
       3,    0,   65,    2, 0x02 /* Public */,
       4,    1,   66,    2, 0x02 /* Public */,
       5,    0,   69,    2, 0x02 /* Public */,
       6,    0,   70,    2, 0x02 /* Public */,
       7,    1,   71,    2, 0x02 /* Public */,
       8,    1,   74,    2, 0x02 /* Public */,
       9,    1,   77,    2, 0x02 /* Public */,
      10,    1,   80,    2, 0x02 /* Public */,
      11,    1,   83,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,

       0        // eod
};

void run_command::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<run_command *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->run(); break;
        case 1: _t->console_fill(); break;
        case 2: _t->conectar_dispositivo((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->desconectar_dispositivos(); break;
        case 4: { QString _r = _t->grabPath();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->debugNetGraber((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->query1((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: _t->query2((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: _t->query3((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->query4((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject run_command::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_run_command.data,
    qt_meta_data_run_command,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *run_command::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *run_command::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_run_command.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int run_command::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
