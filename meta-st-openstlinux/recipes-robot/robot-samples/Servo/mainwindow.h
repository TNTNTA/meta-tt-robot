#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QDebug>
#include <QString>
#include <QtMath>
#include <QDialog>
#include <QPainter>
#include <QPaintEvent>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

protected:
    void paintEvent(QPaintEvent*);
private:
    void DrawPoint(QPainter& painter,int radius);
    void DrawDigital(QPainter& painter,int radius);
    void DrawPointer(QPainter& painter,int radius, int degRotate);
    void DrawCircle(QPainter &painter, int radius);
    void DrawSmallScale(QPainter& painter,int radius);
    void DrawText(QPainter& painter,int radius, const QString& name, const QString& deg);
private:
    QVector<int> degRotate;
    QVector<QPoint> location;

private slots:
    void valueChanged(int value);
private:
    Ui::MainWindow *ui;

};
#endif // MAINWINDOW_H
