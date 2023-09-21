#!/usr/bin/env bash

# 获取本地环境中 Chrome 的大版本号
CHROME_VERSION=$(google-chrome --version | cut -f 3 -d ' ' | cut -d '.' -f 1) 
echo "当前 Chrome 大版本号为: $CHROME_VERSION" 

# 获取对应的 ChromeDriver 版本号
curl --silent --show-error --location --fail --retry 3 --output /tmp/LATEST_RELEASE_${CHROME_VERSION}.txt "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${CHROME_VERSION}" 
CHROMEDRIVER_VERSION=$(cat /tmp/LATEST_RELEASE_${CHROME_VERSION}.txt) 
echo "当前支持的 ChromeDriver 版本号为: $CHROMEDRIVER_VERSION" 

# 下载对应的 ChromeDriver 压缩包到临时目录 /tmp
curl --silent --show-error --location --fail --retry 3 --output /tmp/chromedriver-linux64.zip "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROMEDRIVER_VERSION/linux64/chromedriver-linux64.zip" 
echo "ChromeDriver $CHROMEDRIVER_VERSION 下载完毕" 

# 解压缩对应的 ChromeDriver
unzip /tmp/chromedriver-linux64.zip 
echo "ChromeDriver $CHROMEDRIVER_VERSION 解压完毕" 

# 删除下载的临时文件
rm -rf /tmp/LATEST_RELEASE_${CHROME_VERSION}.txt
rm -rf /tmp/chromedriver-linux64.zip 
echo "删除临时文件完毕" 
ls
echo "把 ChromeDriver 二进制文件移动到用户可执行目录" 
cd /tmp
sudo mv chromedriver-linux64 /usr/local/bin/chromedriver 

echo "给 ChromeDriver 二进制文件添加执行权限" 
sudo chmod +x /usr/local/bin/chromedriver 

# 显示当前安装的 ChromeDriver 的版本号
chromedriver --version
            
