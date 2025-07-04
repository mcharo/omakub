# Make video calls using https://zoom.us/
cd /tmp

# Detect architecture and set appropriate download URL
ARCH=$(uname -m)
case $ARCH in
  x86_64)
    ZOOM_ARCH="amd64"
    ;;
  aarch64)
    ZOOM_ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

wget https://zoom.us/client/latest/zoom_${ZOOM_ARCH}.deb
sudo apt install -y ./zoom_${ZOOM_ARCH}.deb
rm zoom_${ZOOM_ARCH}.deb
cd -
