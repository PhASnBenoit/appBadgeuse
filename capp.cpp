#include "capp.h"

CApp::CApp(QObject *parent) : QObject(parent)
{
    _rfid.PCD_Init();
    _gpio04 = new CGpio(nullptr, 4, OUT);
    _gpio04->clignote(5, 100000, 100000);
    _gpio18 = new CGpio(nullptr, 18, OUT);
    _gpio18->clignote(5, 100000, 100000);

    sleep(5);  // attente établissement réseau WIFI

    _gui = new CGui(nullptr);
    _gui->show();
    connect(_gui, &CGui::sig_isCard, this, &CApp::on_isCard);
    connect(this, &CApp::sig_afficher, _gui, &CGui::on_afficher);
    if (!_bdd.open("192.168.1.44", "badgeur", "badgeur", "bdd_badgeuse"))
        emit sig_afficher("Problème d'accès à la BDD, voir paramètres ligne 17 de capp.cpp");
    else
        emit sig_afficher("Accès à la BDD valide");
    // au démarrage seulement
    _dt1 = QDateTime::currentDateTime().addDays(-1);
    _dt2 = QDateTime::currentDateTime().addDays(1);
}

CApp::~CApp()
{
    delete _gpio04;
    delete _gpio18;
    delete _gui;
}

int CApp::badgeLu(QString tag)
{
    QDateTime dt = QDateTime::currentDateTime();
    QString dateCourante = dt.toString("yyyy-MM-dd hh:mm:ss");
    QString day = dt.date().toString("yyyy-MM-dd");
    QString dateDeb;
    int pk;
    int nbBip=1; // arrivée de l'étudiant
    if (_bdd.testExistenceBadge(tag)<1) {
        _bdd.sauverNouveauBadge(tag, dateCourante);
        nbBip = 0;
    } else {
        int ide = _bdd.getIdEtudiant(tag);
        if (_bdd.testEtudiantEncorePresent(ide, day, pk, dateDeb)<1) {
            _bdd.insererPresence(ide, dateCourante);
        } else { // mise à jour de l'enregistrement
            QDateTime dtd = QDateTime::fromString(dateDeb, "yyyy-MM-dd hh:mm:ss");
            qint64 diff = dtd.secsTo(dt);
            if ( diff > 60) {
                _bdd.updateFinPresence(pk, dateCourante);
                nbBip = 2; // sortie de l'étudiant
            } else {
                nbBip = 6;
            } // else 60s
        } // else
    }// else
    return nbBip;
}

void CApp::on_isCard()
{
    bool is = _rfid.PICC_IsNewCardPresent();
    if (is) {
        emit sig_afficher("CLS");  // code pour effacer l'editText
        _dt = QDateTime::currentDateTime();
        emit sig_afficher("Carte présente !");
        if (_rfid.PICC_ReadCardSerial()) {
            QString id = QString::number(_rfid.uid.size);
            emit sig_afficher(id+" octets lus !");
        } // is
        QString ch;
        for(byte i = 0; i < _rfid.uid.size; ++i){
          if(_rfid.uid.uidByte[i] < 0x10)
             ch+="0";
          ch+=QString::number(_rfid.uid.uidByte[i],16);
        } // for i
        int res = badgeLu(ch);
        QString nom, prenom;
        switch(res) {
        case -1: // erreur ouverture BDD 3 bips
            _gpio18->clignote(3, 200000, 200000);
            emit sig_afficher("BDD HS !");
            break;
        case 0: // erreur badge existe pas 3 bips            
            _gpio18->clignote(3, 200000, 200000);
            emit sig_afficher("Erreur la badge n'existe pas dans la BDD !");
            break;
        case 1: // arrivée 1 bip
            _gpio04->clignote(1, 200000, 200000);
            _dt1 = _dt;
            _bdd.getIdentite(ch,nom, prenom);
            emit sig_afficher("Bienvenue "+nom+" "+prenom+" !");
            break;
        case 2:  // départ 2 bips
            _gpio04->clignote(2, 200000, 200000);
            _dt2 = _dt;
            _bdd.getIdentite(ch,nom, prenom);
            emit sig_afficher("Au revoir "+nom+" "+prenom+" !");
            break;
        case 6: // repassage trop rapide
            _gpio18->clignote(6, 200000, 200000);
            emit sig_afficher("Le badge est déjà passé !");
            break;
        default: break;
        } // sw
        emit sig_afficher(ch);
    } // for id is
}
