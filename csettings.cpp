#include "csettings.h"

CSettings::CSettings()
{
    QSettings settings("appBadgeuse.ini", QSettings::IniFormat);
    _bddHostName = settings.value("BDD/HOST_SGBD", "localhost").toString();
    _bddName = settings.value("BDD/BDD_NAME", "bdd_badgeuse").toString();
    _login = settings.value("BDD/LOGIN", "toto").toString();
    _password = settings.value("BDD/PASSWORD", "toto").toString();
}

QString CSettings::getBddHostName() const
{
    return _bddHostName;
}

QString CSettings::getBddName() const
{
    return _bddName;
}

QString CSettings::getLogin() const
{
    return _login;
}

QString CSettings::getPassword() const
{
    return _password;
}

