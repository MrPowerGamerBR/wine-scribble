# sudo rm -rf output
mkdir -p output
sudo docker build -t wine-scribble-wow64-dev-env --file WineWOW64.Dockerfile .
sudo docker run --mount type=bind,src=./output,dst=/root/output wine-scribble-wow64-dev-env /bin/bash -c "bash update.sh && bash build-wine-wow64.sh"
# We don't tar because the workflow already does that for us
# cd output32
# tar -zcvf ../wine-scribble-x86.tar.gz . && cd -
