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
OPENCV_ROOT="/usr/include" #/usr/local/opencv320/
#INCLUDEPATH += /usr/local/opencv320/include \
#/usr/local/include/opencv \
#/usr/local/include/opencv2
INCLUDEPATH += $$OPENCV_ROOT \
$$OPENCV_ROOT/opencv \
$$OPENCV_ROOT/opencv2

OPENCV_LIB_DIR="/usr/lib/x86_64-linux-gnu" #/usr/local/lib/
#LIBS += $$OPENCV_LIB_DIR/libopencv_aruco.so \
#$$OPENCV_LIB_DIR/libopencv_bgsegm.so \
#$$OPENCV_LIB_DIR/libopencv_bioinspired.so \
#$$OPENCV_LIB_DIR/libopencv_calib3d.so \
#$$OPENCV_LIB_DIR/libopencv_ccalib.so \
#$$OPENCV_LIB_DIR/libopencv_core.so \
#$$OPENCV_LIB_DIR/libopencv_datasets.so \
#$$OPENCV_LIB_DIR/libopencv_dnn.so \
#$$OPENCV_LIB_DIR/libopencv_dpm.so \
#$$OPENCV_LIB_DIR/libopencv_face.so \
#$$OPENCV_LIB_DIR/libopencv_features2d.so \
#$$OPENCV_LIB_DIR/libopencv_flann.so \
#$$OPENCV_LIB_DIR/libopencv_freetype.so \
#$$OPENCV_LIB_DIR/libopencv_fuzzy.so \
#$$OPENCV_LIB_DIR/libopencv_highgui.so \
#$$OPENCV_LIB_DIR/libopencv_imgcodecs.so \
#$$OPENCV_LIB_DIR/libopencv_imgproc.so \
#$$OPENCV_LIB_DIR/libopencv_ml.so \
#$$OPENCV_LIB_DIR/libopencv_objdetect.so \
#$$OPENCV_LIB_DIR/libopencv_optflow.so \
#$$OPENCV_LIB_DIR/libopencv_phase_unwrapping.so \
#$$OPENCV_LIB_DIR/libopencv_photo.so \
#$$OPENCV_LIB_DIR/libopencv_plot.so \
#$$OPENCV_LIB_DIR/libopencv_reg.so \
#$$OPENCV_LIB_DIR/libopencv_rgbd.so \
#$$OPENCV_LIB_DIR/libopencv_saliency.so \
#$$OPENCV_LIB_DIR/libopencv_shape.so \
#$$OPENCV_LIB_DIR/libopencv_stereo.so \
#$$OPENCV_LIB_DIR/libopencv_stitching.so \
#$$OPENCV_LIB_DIR/libopencv_structured_light.so \
#$$OPENCV_LIB_DIR/libopencv_superres.so \
#$$OPENCV_LIB_DIR/libopencv_surface_matching.so \
#$$OPENCV_LIB_DIR/libopencv_text.so \
#$$OPENCV_LIB_DIR/libopencv_tracking.so \
#$$OPENCV_LIB_DIR/libopencv_video.so \
#$$OPENCV_LIB_DIR/libopencv_videoio.so \
#$$OPENCV_LIB_DIR/libopencv_videostab.so \
#$$OPENCV_LIB_DIR/libopencv_xfeatures2d.so \
#$$OPENCV_LIB_DIR/libopencv_ximgproc.so \
#$$OPENCV_LIB_DIR/libopencv_xobjdetect.so \
#$$OPENCV_LIB_DIR/libopencv_xphoto.so
LIBS += $$OPENCV_LIB_DIR/libopencv_calib3d.so \
$$OPENCV_LIB_DIR/libopencv_contrib.so \
$$OPENCV_LIB_DIR/libopencv_core.so \
$$OPENCV_LIB_DIR/libopencv_features2d.so \
$$OPENCV_LIB_DIR/libopencv_flann.so \
$$OPENCV_LIB_DIR/libopencv_gpu.so \
$$OPENCV_LIB_DIR/libopencv_highgui.so \
$$OPENCV_LIB_DIR/libopencv_imgproc.so \
$$OPENCV_LIB_DIR/libopencv_legacy.so \
$$OPENCV_LIB_DIR/libopencv_ml.so \
$$OPENCV_LIB_DIR/libopencv_objdetect.so \
$$OPENCV_LIB_DIR/libopencv_ocl.so \
$$OPENCV_LIB_DIR/libopencv_photo.so \
$$OPENCV_LIB_DIR/libopencv_stitching.so \
$$OPENCV_LIB_DIR/libopencv_superres.so \
$$OPENCV_LIB_DIR/libopencv_ts.so \
$$OPENCV_LIB_DIR/libopencv_video.so \
$$OPENCV_LIB_DIR/libopencv_videostab.so


#include caffe
# set caffe
CAFFE_ROOT="/caffe" #/home/wangpengcheng/caffe/caffe
INCLUDEPATH += $$CAFFE_ROOT/include \
               $$CAFFE_ROOT/src  \
               $$CAFFE_ROOT/include \
CAFFE_LIB_DIR="/caffe/build/lib" #/home/wangpengcheng/caffe/caffe/build/lib
LIBS += -L $$CAFFE_LIB_DIR
LIBS += -lcaffe

# other dependencies
LIBS += -lglog -lgflags -lprotobuf -lboost_system -lboost_thread -llmdb -lleveldb -lstdc++  #-lcblas -latlas


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
