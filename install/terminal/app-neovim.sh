cd /tmp

# Detect architecture and set appropriate download URL
ARCH=$(uname -m)
case $ARCH in
  x86_64)
    NEOVIM_ARCH="x86_64"
    ;;
  aarch64)
    NEOVIM_ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-${NEOVIM_ARCH}.tar.gz"
tar -xf nvim.tar.gz
sudo install nvim-linux-${NEOVIM_ARCH}/bin/nvim /usr/local/bin/nvim
sudo cp -R nvim-linux-${NEOVIM_ARCH}/lib /usr/local/
sudo cp -R nvim-linux-${NEOVIM_ARCH}/share /usr/local/
rm -rf nvim-linux-${NEOVIM_ARCH} nvim.tar.gz
cd -

# Install luarocks and tree-sitter-cli to resolve lazyvim :checkhealth warnings
sudo apt install -y luarocks tree-sitter-cli

# Only attempt to set configuration if Neovim has never been run
if [ ! -d "$HOME/.config/nvim" ]; then
  # Use LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  # Remove the .git folder, so you can add it to your own repo later
  rm -rf ~/.config/nvim/.git

  # Make everything match the terminal transparency
  mkdir -p ~/.config/nvim/plugin/after
  cp ~/.local/share/omakub/configs/neovim/transparency.lua ~/.config/nvim/plugin/after/

  # Default to Tokyo Night theme
  cp ~/.local/share/omakub/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

  # Turn off animated scrolling
  cp ~/.local/share/omakub/configs/neovim/snacks-animated-scrolling-off.lua ~/.config/nvim/lua/plugins/

  # Turn off relative line numbers
  echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua
fi

# Replace desktop launcher with one running inside Alacritty
if [[ -d ~/.local/share/applications ]]; then
  sudo rm -rf /usr/share/applications/nvim.desktop
  source ~/.local/share/omakub/applications/Neovim.sh
fi
