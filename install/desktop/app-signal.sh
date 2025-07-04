# Detect architecture and set appropriate APT source
ARCH=$(uname -m)
case $ARCH in
  x86_64)
    SIGNAL_ARCH="amd64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    return 0
    ;;
esac

wget -qO- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor >signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg >/dev/null
echo "deb [arch=${SIGNAL_ARCH} signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" |
	sudo tee /etc/apt/sources.list.d/signal-xenial.list
rm signal-desktop-keyring.gpg
sudo apt update
sudo apt install -y signal-desktop
