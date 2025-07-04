# Gum is used for the Omakub commands for tailoring Omakub after the initial install
cd /tmp

# Detect architecture and set appropriate download URL
ARCH=$(uname -m)
case $ARCH in
  x86_64)
    GUM_ARCH="amd64"
    ;;
  aarch64)
    GUM_ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

GUM_VERSION="0.14.3" # Use known good version
wget -qO gum.deb "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_${GUM_ARCH}.deb"
sudo apt-get install -y --allow-downgrades ./gum.deb
rm gum.deb
cd -
