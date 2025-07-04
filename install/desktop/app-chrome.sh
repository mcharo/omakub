# Browse the web with the most popular browser. See https://www.google.com/chrome/
cd /tmp

# Detect architecture and install appropriate browser
ARCH=$(uname -m)
case $ARCH in
  x86_64)
    # Install Google Chrome on x86_64
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install -y ./google-chrome-stable_current_amd64.deb
    rm google-chrome-stable_current_amd64.deb
    xdg-settings set default-web-browser google-chrome.desktop
    ;;
  aarch64)
    # Install Chromium on ARM64 (Google Chrome doesn't officially support ARM64 on Linux)
    sudo apt update
    sudo apt install -y chromium-browser

    # Create a wrapper script to provide google-chrome compatibility
    sudo tee /usr/local/bin/google-chrome > /dev/null <<EOF
#!/bin/bash
# Wrapper script to provide google-chrome compatibility on ARM64
exec chromium-browser "\$@"
EOF
    sudo chmod +x /usr/local/bin/google-chrome

    # Create a desktop file for google-chrome that points to chromium
    sudo tee /usr/share/applications/google-chrome.desktop > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Name=Google Chrome (Chromium)
Comment=Access the Internet
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=google-chrome %U
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=chromium-browser
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml_xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true
EOF

    xdg-settings set default-web-browser google-chrome.desktop
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

cd -
