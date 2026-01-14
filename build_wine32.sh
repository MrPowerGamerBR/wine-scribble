mkdir output32
rm -rf output32/*
sudo docker build -t wine-scribble-dev-env .
sudo docker run --mount type=bind,src=./output32,dst=/root/output32 wine-scribble-dev-env /bin/bash -c "bash update.sh && mkdir build32 && cd build32 && ../wine/configure --prefix=/root/output32 --with-x --without-mingw CFLAGS=\"-m32\" LDFLAGS=\"-m32\" && make -j$(nproc) && make install"
# We don't tar because the workflow already does that for us
# cd output32
# tar -zcvf ../wine-scribble-x86.tar.gz . && cd -
