@echo off
REM 文件压缩脚本
REM 用到的参数：
REM -r 20 帧率20
REM -vf scale=iw*0.75:ih*0.75 分辨率为原来的0.75
REM -b:v 500k 视频的码率为500k
echo "===== start compress video ====="

for /l %%i in (1,1,10) do (
    if %%i LSS 10 (
        if not exist compress\S0%%i (
            md compress\S0%%i
        )
        cd S0%%i
        for %%c in (*.mp4) do (
            ffmpeg -i %%c -r 20 -vf scale=iw*0.75:ih*0.75 -b:v 500k ..\compress\S0%%i\%%c -y
        )
    ) else (
        if not exist compress\S%%i (
            md compress\S%%i
        )
        for %%c in (*.mp4) do (
            ffmpeg -i %%c -r 20 -vf scale=iw*0.75:ih*0.75 -b:v 500k ..\compress\S%%i\%%c -y
        )
        cd S%%i
    )
    cd ..
)
echo "===== compress video finish ====="
exit