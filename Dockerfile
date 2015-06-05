FROM kaixhin/cuda-caffe
MAINTAINER Chris Chow <chris.kr.chow@gmail.com>
# install fast-rcnn's deps
RUN apt-get update && \
	apt-get install -y git python-numpy cython python-pip python-skimage \
	python-protobuf python-opencv python-pandas python-yaml

RUN	pip install easydict

# build fast-rcnn
RUN cd /opt && \
	git clone --recursive https://github.com/rbgirshick/fast-rcnn.git

ADD Makefile.config /opt/fast-rcnn/caffe-fast-rcnn/Makefile.config

RUN	cd /opt/fast-rcnn/lib && make -j4 && \
	cd ../caffe-fast-rcnn && make -j4 && make -j4 pycaffe
