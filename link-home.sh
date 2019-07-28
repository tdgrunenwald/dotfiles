#!/bin/sh
PWD=`pwd`
cd `dirname $0`
for F in home/*
do
	ln -s `pwd`/$F $HOME/.`basename $F`
done 
cd $PWD
