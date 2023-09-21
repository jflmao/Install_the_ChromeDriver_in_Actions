#!/usr/bin/env bash

CHROME_VERSION=$(google-chrome --version | cut -f 3 -d ' ' | cut -d '.' -f 1) 
echo "当前 Chrome 大版本号为: $CHROME_VERSION" 
curl --silent --show-error --location --fail --retry 3 --output /tmp/LATEST_RELEASE_${CHROME_VERSION}.txt "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${CHROME_VERSION}" 
CHROMEDRIVER_RELEASE=$(cat /tmp/LATEST_RELEASE_${CHROME_VERSION}.txt) 
echo "当前支持的 ChromeDriver 版本号为: $CHROMEDRIVER_RELEASE" 
curl --silent --show-error --location --fail --retry 3 --output /tmp/chromedriver_linux64.zip "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROMEDRIVER_RELEASE/linux64/chromedriver-linux64.zip" 
echo "ChromeDriver $CHROMEDRIVER_RELEASE 下载完毕" 
cd /tmp 
unzip chromedriver_linux64.zip 
echo "ChromeDriver $CHROMEDRIVER_RELEASE 解压完毕" 
rm -rf chromedriver_linux64.zip 
echo "删除压缩包完毕" 
echo "把 ChromeDriver 二进制文件移动到用户可执行目录" 
sudo mv chromedriver-linux64 /usr/local/bin/chromedriver 
echo "给 ChromeDriver 二进制文件添加执行权限" 
sudo chmod +x /usr/local/bin/chromedriver 
chromedriver --version
            
