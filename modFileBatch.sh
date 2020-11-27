#!/bin/sh

#越特殊的替换越需要放前面
modifySrcArray=(
"ZJUtilsDef"
"ZJBaseUtils"
#"2020 ZJ"
"zj_"
"Zj_"
"ZJ"
)
modifyDstArray=(
"JMSmartUtilsDef"
"JMSmartUtils"
#"2020 Jimi"
"jm_"
"Jm_"
"JM"
)

SHELL_PATH=`pwd`
SHELL_NAME=''

#修改文件内容函数
function modify_file_content() {
    local modifyContentFile=$1

    echo "修改文件内容：$modifyContentFile"
    for (( i = 0; i < ${#modifySrcArray[@]}; i++ ))
    do
        perl -pi -e 's|'${modifySrcArray[$i]}'|'${modifyDstArray[$i]}'|g' $modifyContentFile
        #替换规则："s|查找的字符串|替换的字符串|g"
    done
}

#修改文件名称特殊字符
function modify_file_name() {
    local modifyNameFile=$1
    
    local dname=`dirname $modifyNameFile`        #获取上级目录
    local fname=`basename $modifyNameFile`        #获取文件名
    for (( i = 0; i < ${#modifySrcArray[@]}; i++ ))
    do
        #暂不支持带空格的文件名修改
        spaceResult=$(echo ${modifySrcArray[$i]} | grep " ")
        if [[ "$spaceResult" != "" ]]
        then
           continue
        fi
         
#        fname=`echo $fname | awk '{gsub(/${modifySrcArray[$i]}/,"${modifyDstArray[$i]}"); print }'`
        fname=`echo $fname | sed 's|'${modifySrcArray[$i]}'|'${modifyDstArray[$i]}'|g'` #查找替换字符

        if [ "$fname" != "" ]
        then
            local newfile=$dname/$fname   #新文件的路径
            if [ "$modifyNameFile" != "$newfile" ]  #不相等时修改文件名称
            then
                mv $modifyNameFile $newfile
                echo "修改文件名称：$modifyNameFile -> $newfile"
                break
            fi
        else
            echo "替换规则错误：${modifySrcArray[$i]} -> ${modifyDstArray[$i]}"
        fi
    done
}

#遍历所有文件夹
function traverseFolder() {
    local folder=$1
    if [ "$folder" == "" ]
    then
        echo "未填入需修改的文件夹路径，退出程序！"
        exit
    fi
    
    #获取脚本的路径，后面阻止修改脚本内容
    if [ "$SHELL_NAME" = "" ]
    then
        fname=`basename $0`
        SHELL_NAME=`pwd`/$fname
    fi

    #将./转换为绝对路径
    if [[ "$folder" == ./* ]];then
        local pwdPath=`pwd`
        folder=`echo $folder | sed 's|./|'$pwdPath'|g'`
    fi
    
    #将.转换为绝对路径
    if [ "$folder" == "." ];then
        folder=`pwd`
    fi
    
    for file in $(ls $folder)
    do
        local targetFile=$folder/$file
        
        if test -f $targetFile
        then
            if [ "$targetFile" != "$SHELL_NAME" ]
            then
                modify_file_content $targetFile     #修改文件内容
                modify_file_name $targetFile        #修改文件名称
            fi
        fi

        if test -d "$targetFile"
        then
            traverseFolder $targetFile      #循环遍历文件夹
            modify_file_name $targetFile
        fi
    done
}

#执行遍历修改文件
traverseFolder ./ZJBaseUtils
