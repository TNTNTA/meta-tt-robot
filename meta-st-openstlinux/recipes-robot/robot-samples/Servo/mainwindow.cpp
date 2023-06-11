#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    setFixedSize(800,480);
    for (int i =0; i< 4; i++)
        degRotate.insert(i, -90);

    location.insert(0, QPoint(200, 190));
    location.insert(1, QPoint(400, 0));
    location.insert(2, QPoint(-400, 220));
    location.insert(3, QPoint(400, 0));
    //设置背景墙
    QPalette bgpal=palette();
    bgpal.setColor(QPalette::Background,QColor(0,0,0));
    setPalette (bgpal);

    connect(ui->horizontalSlider,SIGNAL(valueChanged(int)),this,SLOT(valueChanged(int)));
    connect(ui->horizontalSlider_2,SIGNAL(valueChanged(int)),this,SLOT(valueChanged(int)));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    int radius=180;
    QString deg;
    QString name;

    //启用反锯齿
    painter.setRenderHint(QPainter::Antialiasing, true);
    painter.setPen(Qt::NoPen);
    //设置画刷颜色
    painter.setBrush(QColor(138,43,226));

    for(int i = 0;i< 4;i++){
        painter.translate(location[i].x(), location[i].y());
        DrawPoint(painter,radius-57);
        DrawDigital(painter,radius-35);
        DrawCircle(painter,radius-60);
        DrawSmallScale(painter,radius-80);
        deg = QString::number(degRotate[i]+90);
        name = QString("舵机")+QString::number(i);
        DrawText(painter,radius-110,name,deg);
        DrawPointer(painter,radius-92, degRotate[i]);
    }
}
//绘制外圈点
void MainWindow::DrawPoint(QPainter& painter,int radius)
{
    //组装点的路径图
    QPainterPath pointPath;
    pointPath.moveTo(-2,-2);
    pointPath.lineTo(2,-2);
    pointPath.lineTo(2,2);
    pointPath.lineTo(0,4);
    pointPath.lineTo(-2,2);
    //绘制13个小点
    for(int i=0;i<10;++i){
        QPointF point(0,0);
        painter.save();
        painter.setBrush(QColor(255,127,80));
        //计算并移动绘图对象中心点
        point.setX(radius*qCos(((180-i*20)*M_PI)/180));
        point.setY(radius*qSin(((180-i*20)*M_PI)/180));
        //计算并移动绘图对象的中心点
        painter.translate(point.x(),-point.y());
        //计算并选择绘图对象坐标
        painter.rotate(-90+i*20);
        //绘制路径
        painter.drawPath(pointPath);
        painter.restore();
    }
}
void MainWindow::DrawDigital(QPainter& painter,int radius)
{
    //设置画笔，画笔默认NOPEN
    painter.setPen(QColor(218,112,214));
    QFont font;
    //font.setFamily("Cambria");
    font.setPointSize(8);
    painter.setFont(font);
    for(int i=0;i<10;++i){
        QPointF point(0,0);
        painter.save();
        point.setX(radius*qCos(((180-i*20)*M_PI)/180));
        point.setY(radius*qSin(((180-i*20)*M_PI)/180));
        painter.translate(point.x(),-point.y());
        painter.rotate(-90+i*20);
        painter.drawText(-15, 0, 30, 20,Qt::AlignCenter,QString::number(i*20));
        painter.restore();
    }
    //还原画笔
    painter.setPen(Qt::NoPen);
}
void MainWindow::DrawPointer(QPainter& painter,int radius, int degRotate)
{
    //组装点的路径图
    QPainterPath pointPath;
    pointPath.moveTo(8,0);
    pointPath.lineTo(1,-radius);
    pointPath.lineTo(-1,-radius);
    pointPath.lineTo(-8,0);
    pointPath.arcTo(-8,0,16,16,180,180);

    //中间的圆圈
    QPainterPath inRing;
    inRing.addEllipse(-5,-5,10,10);

    painter.save();
    //添加渐变色
    QRadialGradient radialGradient(0,0,radius,0,0);
    radialGradient.setColorAt(0,QColor(0,199,140,150));
    radialGradient.setColorAt(1,QColor(255,153,18,150));
    //计算并选择绘图对象坐标
    painter.rotate(degRotate);
    painter.setBrush(radialGradient);
    painter.drawPath(pointPath.subtracted(inRing));
    painter.restore();
}
void MainWindow::DrawCircle(QPainter& painter,int radius)
{
    //保存绘图对象
    painter.save();
    //计算大小圆路径
    QPainterPath outRing;
    QPainterPath inRing;
    outRing.moveTo(0,0);
    inRing.moveTo(0,0);
    outRing.arcTo(-radius,-radius, 2*radius,2*radius,0,180);
    inRing.addEllipse(-radius+15,-radius+15,2*(radius-15),2*(radius-15));
    outRing.closeSubpath();
    //设置渐变色k
    QRadialGradient radialGradient(0,0,radius,0,0);
    radialGradient.setColorAt(0.93,QColor(138,43,226));
    radialGradient.setColorAt(1,QColor(0,0,0));
    //设置画刷
    painter.setBrush(radialGradient);
    //大圆减小圆
    painter.drawPath(outRing.subtracted(inRing));
    //painter.drawPath(outRing);
    //painter.drawPath(inRing);
    painter.restore();
}
void MainWindow::DrawSmallScale(QPainter& painter,int radius)
{
    //组装点的路径图
    QPainterPath pointPath;
    pointPath.moveTo(-2,-2);
    pointPath.lineTo(-1,-3);
    pointPath.lineTo(1,-3);
    pointPath.lineTo(2,-2);
    pointPath.lineTo(1,5);
    pointPath.lineTo(-1,5);
    //绘制90个小点
    for(int i=0;i<90;++i){
        QPointF point(0,0);
        painter.save();
        point.setX(radius*qCos(((180-i*2)*M_PI)/180));
        point.setY(radius*qSin(((180-i*2)*M_PI)/180));
        painter.translate(point.x(),-point.y());
        painter.rotate(-90+i*2);
        if(i>=90) painter.setBrush(QColor(250,0,0));
        painter.drawPath(pointPath);
        painter.restore();
    }
}
//绘制中心文字
void MainWindow::DrawText(QPainter& painter,int radius, const QString& name, const QString& deg)
{
    painter.save();
    painter.setPen(QColor(255,255,255));
    QFont font;
    //font.setFamily("Cambria");
    font.setPointSize(8);
    painter.setFont(font);
    painter.drawText(-25, -radius+13, 50, 20,Qt::AlignCenter, deg);
    painter.drawText(-25, -radius-10, 50, 20,Qt::AlignCenter, name);
    painter.restore();
}
void MainWindow::valueChanged(int value)
{
    QObject* obj = qobject_cast<QObject*>(sender());

    if(QString::compare(obj->objectName(), "horizontalSlider"))
        this->degRotate[0]= this->degRotate[1]= value;
    if(QString::compare(obj->objectName(), "horizontalSlider_2"))
        this->degRotate[2]= this->degRotate[3] = value;

    update();
    qDebug() <<"objname: "<< obj->objectName() << "value: " << value;
}

