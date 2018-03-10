#!/bin/bash
set -e
PROJ_ROOT=$PWD
BUILD_ROOT=$PROJ_ROOT
echo -e "\033[31m Current Build Root：$BUILD_ROOT \033[0m"

INCLUDE_NAME=include
BIN_NAME=bin
LIB_NAME=lib
SRC_NAME=src
BUILD_NAME=build
BIN_PATH=$BUILD_ROOT/$BIN_NAME
INC_PATH=$BUILD_ROOT/$INCLUDE_NAME
LIB_PATH=$BUILD_ROOT/$LIB_NAME
BUILD_PATH=$BUILD_ROOT/$BUILD_NAME

function collectInc()
{
	DEST_PATH="./include/"
	hearders=`find . -name *.h`
	for file in $hearders
	do
		temp=${file#*/}
		temp=${temp#*/}
		dstfile=$DEST_PATH$temp
		dstpath=${dstfile%/*}
		[ -d $dstpath ] || mkdir -p $dstpath
		cp -R $file $dstfile
	done
}

function prepare()
{
	mkdir -p $INC_PATH
	mkdir -p $BIN_PATH
	mkdir -p $LIB_PATH
	mkdir -p $PROJ_ROOT/$SRC_NAME
	mkdir -p $BUILD_PATH

	#exe dir
	if [ -d $BIN_PATH ];then
		rm -rf $BIN_PATH/*
	fi

	if [ -d  $INC_PATH ];then
		rm -rf $INC_PATH/*
	fi

	if [ -d $BUILD_PATH ];then
		rm -rf $BUILD_PATH/*
	fi
}

function doBuild()
{
	prepare
	collectInc
	cd $BUILD_PATH
	cmake $PROJ_ROOT
	make 
}

doBuild
