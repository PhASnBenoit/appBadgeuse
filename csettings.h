#ifndef CSETTINGS_H
#define CSETTINGS_H

#include <QObject>
#include <QSettings>

class CSettings : public QObject
{
public:
    CSettings();
    QString getBddHostName() const;
    QString getBddName() const;
    QString getLogin() const;
    QString getPassword() const;

private:
    QString _bddHostName;
    QString _bddName;
    QString _login;
    QString _password;
};

#endif // CSETTINGS_H
