#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <caffe/blob.hpp>
using namespace std;
using namespace cv;
using namespace caffe;
void cv_test();
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    cv_test();
    return app.exec();
}


void cv_test(){
    Mat img = imread("/home/wangpengcheng/图片/2018-09-04 15-55-00屏幕截图.png");
    if(img.empty())
        {
            cout << "图像加载失败！"<< endl;
            //system("pause");
           // return -1;
        }
        //创建一个名字为MyWindow的窗口
        namedWindow("MyWindow", CV_WINDOW_AUTOSIZE);
        //在MyWindow的窗中中显示存储在img中的图片
        imshow("MyWindow", img);
        //等待直到有键按下
        waitKey(0);
        //销毁MyWindow的窗
        //destroyWindow("MyWindow");
    cout << "Hello World!" << endl;
}
