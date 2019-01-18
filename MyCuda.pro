QT += quick
CONFIG += c++11
CONFIG += debug
# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#set opencv
INCLUDEPATH += /usr/local/opencv320/include \
/usr/local/include/opencv \
/usr/local/include/opencv2

LIBS += /usr/local/lib/libopencv_aruco.so \
/usr/local/lib/libopencv_bgsegm.so \
/usr/local/lib/libopencv_bioinspired.so \
/usr/local/lib/libopencv_calib3d.so \
/usr/local/lib/libopencv_ccalib.so \
/usr/local/lib/libopencv_core.so \
/usr/local/lib/libopencv_datasets.so \
/usr/local/lib/libopencv_dnn.so \
/usr/local/lib/libopencv_dpm.so \
/usr/local/lib/libopencv_face.so \
/usr/local/lib/libopencv_features2d.so \
/usr/local/lib/libopencv_flann.so \
/usr/local/lib/libopencv_freetype.so \
/usr/local/lib/libopencv_fuzzy.so \
/usr/local/lib/libopencv_highgui.so \
/usr/local/lib/libopencv_imgcodecs.so \
/usr/local/lib/libopencv_imgproc.so \
/usr/local/lib/libopencv_ml.so \
/usr/local/lib/libopencv_objdetect.so \
/usr/local/lib/libopencv_optflow.so \
/usr/local/lib/libopencv_phase_unwrapping.so \
/usr/local/lib/libopencv_photo.so \
/usr/local/lib/libopencv_plot.so \
/usr/local/lib/libopencv_reg.so \
/usr/local/lib/libopencv_rgbd.so \
/usr/local/lib/libopencv_saliency.so \
/usr/local/lib/libopencv_shape.so \
/usr/local/lib/libopencv_stereo.so \
/usr/local/lib/libopencv_stitching.so \
/usr/local/lib/libopencv_structured_light.so \
/usr/local/lib/libopencv_superres.so \
/usr/local/lib/libopencv_surface_matching.so \
/usr/local/lib/libopencv_text.so \
/usr/local/lib/libopencv_tracking.so \
/usr/local/lib/libopencv_video.so \
/usr/local/lib/libopencv_videoio.so \
/usr/local/lib/libopencv_videostab.so \
/usr/local/lib/libopencv_xfeatures2d.so \
/usr/local/lib/libopencv_ximgproc.so \
/usr/local/lib/libopencv_xobjdetect.so \
/usr/local/lib/libopencv_xphoto.so


#include caffe
# set caffe
INCLUDEPATH += /home/wangpengcheng/caffe/caffe/include \
               /home/wangpengcheng/caffe/caffe/src  \
               /home/wangpengcheng/caffe/caffe/distribute/include \

LIBS += -L /home/wangpengcheng/caffe/caffe/build/lib
LIBS += -lcaffe

# other dependencies
LIBS += -lglog -lgflags -lprotobuf -lboost_system -lboost_thread -llmdb -lleveldb -lstdc++  -lcblas -latlas


#set cuda
INCLUDEPATH += /usr/local/cuda/include \
               /usr/local/cuda/bin

LIBS += -L/usr/local/cuda/lib64
LIBS += -lcudart \
        -lcublas \
        -lcurand \
        -laccinj64  \
        -lcudnn  \
        -lcufft  \
        -lcufftw  \
        -lcuinj64  \
        -lcusolver  \
        -lcusparse  \
        -lnppc  \
        -lnppial  \
        -lnppicc  \
        -lnppicom  \
        -lnppidei  \
        -lnppif  \
        -lnppig  \
        -lnppim  \
        -lnppist  \
        -lnppisu  \
        -lnppitc  \
        -lnpps  \
        -lnvblas  \
        -lnvgraph  \
        -lnvrtc-builtins  \
        -lnvrtc  \
        -lnvToolsExt  \
        -lOpenCL


DEPENDPATH += .

OTHER_FILES +=

CUDA_SOURCES += cudatest.cu

CUDA_SDK = "/usr/local/cuda"   # Path to cuda SDK install
CUDA_DIR = "/usr/local/cuda"            # Path to cuda toolkit install
SYSTEM_NAME = linux         # Depending on your system either 'Win32', 'x64', or 'Win64'
SYSTEM_TYPE = 64            # '32' or '64', depending on your system
CUDA_ARCH = sm_70      # Type of CUDA architecture, for example 'compute_10', 'compute_11', 'sm_10'
NVCC_OPTIONS = --use_fast_math


INCLUDEPATH += $$CUDA_DIR/include
QMAKE_LIBDIR += $$CUDA_DIR/lib64/

CUDA_OBJECTS_DIR = ./

CUDA_LIBS = cudart cufft curand
CUDA_INC = $$join(INCLUDEPATH,'" -I"','-I"','"')
NVCC_LIBS = $$join(CUDA_LIBS,' -l','-l', '')

CONFIG(debug, debug|release) {
    # Debug mode
    cuda_d.input = CUDA_SOURCES
    cuda_d.output = $$CUDA_OBJECTS_DIR/${QMAKE_FILE_BASE}_cuda.o
    cuda_d.commands = $$CUDA_DIR/bin/nvcc -D_DEBUG $$NVCC_OPTIONS $$CUDA_INC $$NVCC_LIBS --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
    cuda_d.dependency_type = TYPE_C
    QMAKE_EXTRA_COMPILERS += cuda_d
}
else {
    # Release mode
    cuda.input = CUDA_SOURCES
    cuda.output = $$CUDA_OBJECTS_DIR/${QMAKE_FILE_BASE}_cuda.o
    cuda.commands = $$CUDA_DIR/bin/nvcc $$NVCC_OPTIONS $$CUDA_INC $$NVCC_LIBS --machine $$SYSTEM_TYPE -arch=$$CUDA_ARCH -O3 -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME}
    cuda.dependency_type = TYPE_C
    QMAKE_EXTRA_COMPILERS += cuda
}


DISTFILES += \
    cudatest.cu

HEADERS += \
    cudatest.h
