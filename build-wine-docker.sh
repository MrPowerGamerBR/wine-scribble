# sudo rm -rf output
mkdir -p output
sudo docker build -t wine-scribble-dev-env .
sudo docker run --mount type=bind,src=./output,dst=/root/output --mount type=bind,src=./build.sh,dst=/root/build.sh wine-scribble-dev-env /bin/bash -c "bash update.sh && bash build-wine.sh"
# We don't tar because the workflow already does that for us
# cd output32
# tar -zcvf ../wine-scribble-x86.tar.gz . && cd -
