cd /tmp
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

ARCHITECTURE=$(dpkg --print-architecture)
if [ "$ARCHITECTURE" = "arm64" ]; then
    DEB_FILE="LocalSend-${LOCALSEND_VERSION}-linux-arm-64.deb"
else
    DEB_FILE="LocalSend-${LOCALSEND_VERSION}-linux-x86-64.deb"
fi

wget -O localsend.deb "https://github.com/localsend/localsend/releases/latest/download/$DEB_FILE"
sudo apt install -y ./localsend.deb
rm localsend.deb
cd -
