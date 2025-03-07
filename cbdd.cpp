#include "cbdd.h"

CBdd::CBdd(QObject *parent) : QObject(parent)
{

}

CBdd::~CBdd()
{
  _db.close();
}

bool CBdd::open(QString host, QString login, QString passwd, QString bdd)
{
    _db = QSqlDatabase::addDatabase("QMYSQL");
    _db.setHostName(host);
    _db.setUserName(login);
    _db.setPassword(passwd);
    _db.setDatabaseName(bdd);
    return _db.open();
}

QStringList CBdd::quiEtaitPresent(QDateTime dt)
{
    if (!_db.isOpen())
        return QStringList("");
    QSqlQuery q;
    QStringList presents;
    if (!_db.open())
        return QStringList(nullptr);
    q.prepare("SELECT nom, prenom, date_deb, date_fin "
              "FROM etudiants, presences "
              "WHERE etudiants.id_etudiants = presences.id_etudiants "
              "AND DATE(date_deb)=:dd");
    q.bindValue(":dt", dt.toString("yyyy-MM-dd"));
    q.exec();
    for(int i=0 ; i<q.size() ; i++) {
        q.next();
        presents.append(q.value(0).toString()+" "+
                        q.value(1).toString()+" "+
                        q.value(2).toString()+" "+
                        q.value(3).toString()+" ");
    } // for i
    qDebug() << "CBdd::quiEtaitPresent " << presents;
    return presents;
}


bool CBdd::getIdentite(QString ch, QString &nom, QString &prenom)
{
    QSqlQuery q;
    if (!_db.isOpen())
        return false;

    q.prepare("SELECT nom, prenom "
              "FROM etudiants "
              "WHERE tag_rfid=:id");
    q.bindValue(":id", ch);
    q.exec();
    qDebug() << "CBdd::getIdentite " << q.size();
    if (q.size()>0) {
        q.next();
        prenom = QString(q.value(1).toString());
        nom = q.value(0).toString();
        qDebug() << "CBdd::getIdentite " << q.value(0).toString();
    } // if
    return true;
}

int CBdd::testExistenceBadge(QString tag)
{
    if (!_db.isOpen())
        return -1;
    QSqlQuery q;
    q.prepare("SELECT * FROM etudiants "
              "WHERE tag_rfid=:tag");
    q.bindValue(":tag", tag);
    q.exec();
    qDebug() << "CBdd::testExistenceBadge " << q.size();
    return q.size();
}

int CBdd::getIdEtudiant(QString tag)
{
    if (!_db.isOpen())
        return -1;

    QSqlQuery q;
    q.prepare("SELECT id_etudiants "
              "FROM etudiants "
              "WHERE tag_rfid=:tag");
    q.bindValue(":tag", tag);
    q.exec();
    qDebug() << "CBdd::getIdEtudiant " << q.size();
    if (q.size()>0) {
        q.next();
        qDebug() << "CBdd::getIdEtudiant " << q.value(0).toInt();
        return q.value(0).toInt();
    } // if
    return -1;
}

int CBdd::testEtudiantEncorePresent(int ide, QString day, int &pk, QString &dateDeb)
{
    if (!_db.isOpen())
        return -1;

    QSqlQuery q;
    q.prepare("SELECT id_presences, date_deb "
              "FROM presences "
              "WHERE id_etudiants=:ide "
              "AND DATE(date_deb)=:dd "
              "AND DATE(date_fin) = '0000-00-00'");
    q.bindValue(":ide", ide);
    q.bindValue(":dd", day);
    q.exec();
    int nb = q.size();
    qDebug() << "CBdd::testEtudiantEncorePresent " << nb;
    if (nb>0) {
        q.next();
        pk = q.value(0).toInt();
        QDateTime dt = q.value(1).toDateTime();
        dateDeb = dt.toString("yyyy-MM-dd hh:mm:ss");
        qDebug() << "CBdd::testEtudiantEncorePresent " << dateDeb;
    } // if
    return q.size();
}

int CBdd::insererPresence(int id, QString dh)
{
    if (!_db.isOpen())
        return -1;

    QSqlQuery q;
    q.prepare("INSERT INTO presences "
              "VALUES (0, :id, :dd, 0);");
    q.bindValue(":id", id);
    q.bindValue(":dd", dh);
    q.exec();
    qDebug() << "CBdd::insererPresence " << q.numRowsAffected();
    return q.numRowsAffected();
}

int CBdd::updateFinPresence(int pk, QString date)
{
    if (!_db.isOpen())
        return -1;

    QSqlQuery q;
    q.prepare("UPDATE presences "
              "SET date_fin=:dd "
              "WHERE id_presences=:idp");
    q.bindValue(":dd", date);
    q.bindValue(":idp", pk);
    q.exec();
    qDebug() << "CBdd::updateFinPresence " << q.numRowsAffected();
    return q.numRowsAffected();
}

int CBdd::sauverNouveauBadge(QString tag, QString date)
{
    if (!_db.isOpen())
        return -1;

    QSqlQuery q;
    // test si existe déjà
    q.prepare("SELECT * FROM badgesNotAffected "
              "WHERE tag_rfid = :tag");
    q.bindValue(":tag", tag);
    q.exec();
    qDebug() << "CBdd::sauverNouveauBadge " << q.size();
    if (q.size()<1) {
        q.prepare("INSERT INTO badgesNotAffected "
                  "VALUES (0, :tag, :dd)");
        q.bindValue(":tag", tag);
        q.bindValue(":dd", date);
        q.exec();
        qDebug() << "CBdd::sauverNouveauBadge " << q.numRowsAffected();
        return q.numRowsAffected();
    } //
    return 0;
}
