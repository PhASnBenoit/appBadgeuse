#include "cgui.h"
#include "ui_cgui.h"

CGui::CGui(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::CGui)
{
    ui->setupUi(this);
    _tmr.setInterval(1000);
    connect(&_tmr, &QTimer::timeout, this, &CGui::on_timeout);
    on_afficher("ACTIVATION de la détection RFID...");
    _tmr.start();
}

CGui::~CGui()
{
    _tmr.stop();
    delete ui;
}

void CGui::on_afficher(QString txt)
{
    if (txt == "CLS") // protocole maison
        ui->textEdit->clear();
    else
        ui->textEdit->append(txt);
}

void CGui::on_timeout()
{
    //on_afficher("Test présence...");
    emit sig_isCard();
}
