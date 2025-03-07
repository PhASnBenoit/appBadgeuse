#ifndef CBDD_H
#define CBDD_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDateTime>
#include <QVariant>
#include <QDebug>

class CBdd : public QObject
{
    Q_OBJECT
public:
    explicit CBdd(QObject *parent = nullptr);
    ~CBdd();
    QStringList quiEtaitPresent(QDateTime dt);
    bool open(QString host="192.167.1.44",
              QString login="badgeur",
              QString passwd="badgeur",
              QString bdd="bdd_badgeuse");
    bool getIdentite(QString ch, QString &nom, QString &prenom);
    int testExistenceBadge(QString tag);
    int getIdEtudiant(QString tag);
    int testEtudiantEncorePresent(int ide, QString day, int &pk, QString &dateDeb);
    int insererPresence(int id, QString dh);
    int updateFinPresence(int pk, QString date);
    int sauverNouveauBadge(QString tag, QString date);
private:
    QSqlDatabase _db;

signals:

public slots:
};

#endif // CBDD_H
