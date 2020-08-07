#!/bin/bash

current_path=`pwd`
case "`uname`" in
    Darwin)
        bin_abs_path=`cd $(dirname $0); pwd`
        ;;
    Linux)
        bin_abs_path=$(readlink -f $(dirname $0))
        ;;
    *)
        bin_abs_path=`cd $(dirname $0); pwd`
        ;;
esac
BASE=${bin_abs_path}

if [ "$1" == "base" ] ; then
    docker build --no-cache -t iamkyun/osbase $BASE/base
elif [ "$1" == "base_v2" ] ; then
    docker build --no-cache -t iamkyun/osbase $BASE/base_v2 -f $BASE/base_v2/Dockerfile_v2
elif [ "$1" == "base_admin" ] ; then
    docker build --no-cache -t iamkyun/osadmin_admin $BASE/base_admin -f $BASE/base_admin/Dockerfile_admin
elif [ "$1" == "admin" ] ; then
    rm -rf $BASE/canal.*.tar.gz ;
    cd $BASE/../ && mvn clean package -Dmaven.test.skip -Denv=release && cd $current_path ;
    cp $BASE/../target/canal.admin-*.tar.gz $BASE/
    docker build --no-cache -t iamkyun/canal-admin $BASE/ -f $BASE/Dockerfile_admin
else 
    rm -rf $BASE/canal.*.tar.gz ; 
    cd $BASE/../ && mvn clean package -Dmaven.test.skip -Denv=release && cd $current_path ;
    cp $BASE/../target/canal.deployer-*.tar.gz $BASE/
    docker build --no-cache -t iamkyun/canal-server $BASE/
fi
