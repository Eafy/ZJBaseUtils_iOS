#!/bin/sh

#修改文件内容函数
function modify_file_content() {
    file=$1
    echo 修改文件内容：$file
    perl -pi -e 's|replace_text|registry|g' $file
    #在当前路径下的：path文件夹下的所有文件中，"s|查找的字符串|替换的字符串|g"。
}

function modify_file_name() {
    file=$1
    echo 修改文件名称：$file
    newfile=`echo $file | sed 's|ZJ|JM|g'`
    mv $file $newfile
}

#遍历所有文件夹和文件
for file in modtest/*
do
    if test -f $file
    then
        modify_file_content $file
        modify_file_name $file
    fi
    
    if test -d $file
    then
        echo 遍历文件夹：$file
    fi
done
