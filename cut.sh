#!/usr/bin/sh
#文件剪切脚本
echo "===== start cut video ====="
#待剪切文件路径 original/old_friend/Season01
input_path=$1
#输出文件路径 output/old_friend/Season01
output_path=$2
#待剪切的文件 S01E02.mp4
input_file=$3
#剪辑开始时间 0:00:43.73
ss=$4
#剪辑结束时间 0:00:53.73
to=$5

#视频根目录
base_path='/home/video'
#ffmpeg路径
ffmpeg_path="/usr/local/ffmpeg/ffmpeg"

array=(${input_file//./ })
index=${#array[@]}-1
#输出文件后缀，与待剪切文件后缀一致
suffix=${array[index]}

str=${ss}~${to}

#输出文件名
output_file=${str//:/-}.${suffix}
echo "=====  the output_file is ${output_file}=====  "

cd ${base_path}/${input_path}
pwd

echo "======  ${ffmpeg_path} -ss ${ss} -to ${to} -accurate_seek -i ${input_file} -c copy -avoid_negative_ts 1 ${output_file} -y  ======"
${ffmpeg_path} -ss ${ss} -to ${to} -accurate_seek -i ${input_file} -c copy -avoid_negative_ts 1 ${output_file} -y

echo "====== mv ${base_path}/${input_path}/${output_file} ${base_path}/${output_path}/  ======"
mv ${base_path}/${input_path}/${output_file} ${base_path}/${output_path}/



echo "=====  cut video finish  ====="