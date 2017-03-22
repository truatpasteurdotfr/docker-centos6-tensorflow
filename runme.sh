#!/bin/sh
mkdir -p /build/tensorflow_pkg 2>> /dev/null
cd /build/tensorflow-1.0.1 && \
./configure < /tmp/tf-c6.ans && \
bazel build --linkopt='-lrt' --config=opt //tensorflow/tools/pip_package:build_pip_package && \
bazel-bin/tensorflow/tools/pip_package/build_pip_package /build/tensorflow_pkg
cd / && \
pip install --user /build/tensorflow_pkg/tensorflow-1.0.1-cp27-none-linux_x86_64.whl
python <<EOF
# Creates a graph.
import tensorflow as tf
a = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[2, 3], name='a')
b = tf.constant([1.0, 2.0, 3.0, 4.0, 5.0, 6.0], shape=[3, 2], name='b')
c = tf.matmul(a, b)
# Creates a session with log_device_placement set to True.
sess = tf.Session(config=tf.ConfigProto(log_device_placement=True))
# Runs the op.
print sess.run(c)
EOF

