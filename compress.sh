#!/usr/bin/bash
#文件压缩脚本
#用到的参数：
#-r 20 帧率20
#-vf scale=iw*0.75:ih*0.75 #分辨率为原来的0.75
#-b:v 500k #视频的码率为500k
echo "===== start compress video ====="
start_date=$(date "+%Y-%m-%d %H:%M:%S")
echo "$start_date"

#视频文件目录
video="original/old_friend"

#压缩视频文件目录
compress="compress/old_friend"

#从第8季到第10季的视频压缩处理
for i in $(seq 8 10)
do 
    dir="Season0$i"
    if [ $i -ge 10 ]
    then
        dir="Season$i"
    fi
    files=$(ls $video/$dir)
    for file in $files:
    do  
        file=${file%:*}
        in_file=$video/$dir/$file
        out_file=$compress/$dir/$file
        if [ ! -f $out_file ];then
            echo "ffmpeg -i $in_file -r 20 -vf scale=iw*0.75:ih*0.75 -b:v 500k -c:v libx264 $out_file -y"
            ffmpeg -i $in_file -r 20 -vf scale=iw*0.75:ih*0.75 -b:v 500k -c:v libx264 $out_file -y
        else
            echo "$out_file文件已存在"
        fi 
    done
done

echo "===== compress video finish ====="
end_date=$(date "+%Y-%m-%d %H:%M:%S")
echo "$end_date"
sys_date1=$(date -d "$start_date" +%s)
sys_date2=$(date -d "$end_date" +%s)
time=`expr $sys_date2 - $sys_date1`

echo "共花费了: $time"