#ifndef CAPP_H
#define CAPP_H

#include <QObject>
#include <QString>
#include <QDateTime>
#include "cgui.h"
#include "cbdd.h"
#include "cgpio.h"
#include "CMFRC522.h"

class CApp : public QObject
{
    Q_OBJECT
public:
    explicit CApp(QObject *parent = nullptr);
    ~CApp();

private:
    CGui *_gui;
    CMFRC522 _rfid;
    CBdd _bdd;
    QDateTime _dt, _dt1, _dt2;
    CGpio *_gpio04, *_gpio18;
    int badgeLu(QString tag);

signals:
    void sig_afficher(QString txt);

public slots:
    void on_isCard();
};

#endif // CAPP_H
