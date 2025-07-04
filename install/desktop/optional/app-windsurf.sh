# Detect architecture and set appropriate APT source
ARCH=$(uname -m)
case $ARCH in
  x86_64)
    WINDSURF_ARCH="amd64"
    ;;
  aarch64)
    WINDSURF_ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=${WINDSURF_ARCH}] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list >/dev/null

sudo apt update -y
sudo apt install -y windsurf
